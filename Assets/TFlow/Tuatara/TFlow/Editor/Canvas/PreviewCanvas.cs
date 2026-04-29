using System;
using Tuatara.TFlow.Editor.Settings;
using Tuatara.TFlow.Editor.Shaders;
using Tuatara.TFlow.Editor.Window;
using UnityEditor;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Canvas
{
    /// <summary>
    /// Area to display a texture with basic controls (pan, zoom).
    /// </summary>
    public class PreviewCanvas
    {
	    private TFlowWindow Window { get; }

		/// <summary>
		/// Rect used to display the texture. It's affected by pan and zoom tool.
		/// </summary>
		private Rect TextureRect { get; set; }

		private RenderTexture DrawBuffer { get; set; }
	    private bool DirtyDrawBuffer { get; set; }
	    
	    private Texture Frame { get; set; }

	    /// <summary>
	    /// The frame size can be different from `Frame.width` in case we want to use a upsampled
	    /// texture to get cripser results.
	    /// </summary>
	    private int OriginalFrameWidth { get; set; }
	    private int OriginalFrameHeight { get; set; }

	    /// <summary>
        /// Determine which channels to draw in the canvas.
        /// (0, 0, 0, 1) -> Only draw alpha channel (in linear space)
        /// (1, 1, 1, 0) -> Only draw RGB (in sRGB or linear) with alpha 1
        /// (1, 1, 1, 1) -> Draw frame as is
        /// (1, 1, 0, 0) -> Only draw RG (in sRGB or linear) with alpha 1
        /// </summary>
        public Vector4 FrameMask { get; set; } = Mask_DrawAllChannels;


	    public static Vector4 Mask_DrawAllChannels => Vector4.one;
	    public static Vector4 Mask_IgnoreBlueAndAlpha => new Vector4(1, 1, 0, 0);

	    /// <summary>
        /// Canvas display area, relative to the EditorWindow drawing the canvas.
        /// </summary>
        private Rect DisplayRect { get; set; }

		/// <summary>
		/// Texture display area, will change based on texture size, zoom and pan.
		/// </summary>
		private Rect CanvasRelativeRect { get; set; }

	    /// <summary>
        /// True if the user has clicked/selected on the canvas.
        /// This prop can be useful to control the canvas even when the mouse is not hovering it.
        /// </summary>
        private bool HasFocus { get; set; }

		private bool IsTextureSpliting { get; set; } = false;

		/// <summary>
		/// True if the user mouse is hover the canvas.
		/// </summary>
		public bool HasSoftFocus => DisplayRect.Contains(Event.current.mousePosition);


	    private CanvasPanControl PanControl { get; }
	    private CanvasZoomControl ZoomControl { get; }
		/// <summary>
		/// Gets the zoom value normalized.
		/// </summary>
		public float Zoom => ZoomControl.ZoomPercent;

		public bool SplitEnabled { get; set; } = false;
	    private float SplitPos01 { get; set; } = 0.0f;

		private GUIStyle LargeLabel { get; set; }

	    private static readonly int ShaderPropRgbaMask = Shader.PropertyToID("_RGBAMask");

	    public PreviewCanvas(TFlowWindow window)
        {
            Window = window;
            DisplayRect = new Rect(0, 0, 100, 100);

            PanControl = new CanvasPanControl(this);
            ZoomControl = new CanvasZoomControl(this, PanControl);

			LargeLabel = new GUIStyle(EditorStyles.largeLabel);
			LargeLabel.fontSize = 24;

			DrawBuffer = RenderTexture.GetTemporary(1, 1, 0, RenderTextureFormat.ARGBHalf);
			DirtyDrawBuffer = true;
        }

		public void ResetView()
		{
			ZoomControl.Reset();
			PanControl.Reset();
		}

		public void Draw()
		{
			Window.Invalidate();
		}

	    public void Invalidate()
        {
	        DirtyDrawBuffer = true;
	        Draw();
        }

	    /// <summary>
	    /// As opposed to <see cref="Invalidate"/> we don't plan to reuse the canvas afterwards.
	    /// </summary>
	    public void Destroy()
	    {
		    if (DrawBuffer != null)
		    {
			    RenderTexture.ReleaseTemporary(DrawBuffer);
			    DrawBuffer = null;
			    Frame = null;
		    }
	    }

        public void OnGUI(Rect rect)
        {
            DisplayRect = rect;
            
            // Focus on the canvas when clicking on it.
            if (Event.current.type == EventType.MouseDown && HasSoftFocus)
            {
                HasFocus = true;
                UnityEngine.GUI.FocusControl("");
            }
            else if (Event.current.type == EventType.MouseDown)
            {
                HasFocus = false;
            }
            
			UnityEngine.GUI.BeginGroup(DisplayRect);
            var centerRect = new Rect(Vector2.zero, DisplayRect.size);
            CanvasRelativeRect = new Rect(0, 0, DisplayRect.width, DisplayRect.height);

            //=> Render the texture.
            if (Frame != null)
            {
                PanControl.HandlePanControl(CanvasRelativeRect);
                ZoomControl.HandleZoomControl(CanvasRelativeRect);
                DrawCanvasTexture();
            }
            else
            {
				TextureRect = Rect.zero;
				UnityEngine.GUI.Label(centerRect,"No Texture", EditorStyles.centeredGreyMiniLabel);
            }

			DrawSplitControls();
			DrawFrameLimits();
			
			// Draw processing overlay.
			var frameBaked = Window.GlobalProcessingController.IsFrameOrNextFrameOrNextNextFrameBaked();
			if (Window.Settings.Playback.IsPlaying && !frameBaked)
			{
				var processingRect = new Rect(new Vector2(0, DisplayRect.size.y / 2 - 20), DisplayRect.size);
				UnityEngine.GUI.Label(processingRect,"Processing...", EditorStyles.centeredGreyMiniLabel);
			}

			UnityEngine.GUI.EndGroup();
		}

        private void DrawCanvasTexture()
        {
	        if (Frame != null && DirtyDrawBuffer)
	        {
		        // Recreate a buffer is the size changed.
		        if (DrawBuffer.width != Frame.width || DrawBuffer.height != Frame.height)
		        {
			        RenderTexture.ReleaseTemporary(DrawBuffer);
			        DrawBuffer = RenderTexture.GetTemporary(
				        Frame.width,
				        Frame.height,
				        0,
				        RenderTextureFormat.ARGBHalf);
					DrawBuffer.filterMode = FilterMode.Trilinear;
		        }

	            var blitMap = MaterialsCache.Canvas;
	            blitMap.SetColor(ShaderPropRgbaMask, FrameMask);
	            
	            var backup = RenderTexture.active;
	            Graphics.Blit(Frame, DrawBuffer, blitMap);
	            RenderTexture.active = backup;
	        }

	        if (Event.current.type == EventType.Repaint)
            {
	            var textureWidth = OriginalFrameWidth;
                var textureHeight = OriginalFrameHeight;

				TextureRect = new Rect(
                    (CanvasRelativeRect.width / 2) - PanControl.Position.x - (textureWidth * ZoomControl.Zoom * 0.5f),
                    (CanvasRelativeRect.height / 2) - PanControl.Position.y - (textureHeight * ZoomControl.Zoom * 0.5f),
                    textureWidth * ZoomControl.Zoom,
                    textureHeight * ZoomControl.Zoom);

                UnityEngine.GUI.DrawTexture(
					TextureRect,
	                DrawBuffer,
	                ScaleMode.ScaleToFit);
            }
        }

		private void DrawSplitControls()
		{
			var modeSupportsSplit =
				Window.Settings.CanvasMode == SettingsModel.ViewingMode.Blended
				|| Window.Settings.CanvasMode == SettingsModel.ViewingMode.MotionBlur;
			if (!SplitEnabled || TextureRect == Rect.zero || !modeSupportsSplit)
			{ return; }

			//Rect forbiddenRect = new Rect(CanvasRelativeRect.x, PlaybackRect.y, CanvasRelativeRect.width, PlaybackRect.height);
			Rect allowedRect = new Rect(CanvasRelativeRect.x, TextureRect.y, CanvasRelativeRect.width, TextureRect.height); ;
			Rect cursorRect = new Rect(TextureRect.x + TextureRect.width * Window.Settings.PreviewSplit - 6, TextureRect.y, 15.0f, TextureRect.height);

			EditorGUIUtility.AddCursorRect(cursorRect, MouseCursor.SlideArrow);

			if (Event.current.type == EventType.MouseDown && Event.current.button == 0 &&
				allowedRect.Contains(Event.current.mousePosition) /*&&*/ 
				/*!forbiddenRect.Contains(Event.current.mousePosition)*/)
			{ IsTextureSpliting = true; }
			if (Event.current.type == EventType.MouseUp || Event.current.rawType == EventType.MouseUp)
			{ IsTextureSpliting = false; }

			if (IsTextureSpliting && (Event.current.type == EventType.MouseDrag || Event.current.type == EventType.MouseDown) && Event.current.button == 0)
			{
				float split01 = (Event.current.mousePosition.x - TextureRect.x) / TextureRect.width;
				if (Math.Abs(split01 - SplitPos01) > 0.0001f)
				{
					SplitPos01 = split01;
					Window.Settings.PreviewSplit = Mathf.Clamp01(SplitPos01);
					Window.GlobalProcessingController.Draw();
				}
			}

			Rect splitRect = new Rect(TextureRect.x + TextureRect.width * Window.Settings.PreviewSplit, TextureRect.y, 1.0f, TextureRect.height);
			// Draw
			EditorGUI.DrawRect(splitRect, new Color(1.0f, 1.0f, 1.0f, 0.1f));

			Color color = new Color(1.0f, 1.0f, 1.0f, 0.25f);
			EditorGUI.DrawRect(new Rect(splitRect.x - 2, TextureRect.y - 5, 5, 4), color);
			EditorGUI.DrawRect(new Rect(splitRect.x - 2, TextureRect.y + TextureRect.height + 1, 5, 4), color);
		}

		private void DrawFrameLimits()
		{
			Color color = new Color(1.0f, 1.0f, 1.0f, 0.1f);
			// Top
			EditorGUI.DrawRect(new Rect(TextureRect.x - 1, TextureRect.y - 1, TextureRect.width + 1, 1), color);
			// Right
			EditorGUI.DrawRect(new Rect(TextureRect.x + TextureRect.width, TextureRect.y - 1, 1, TextureRect.height + 1), color);
			// Bottom
			EditorGUI.DrawRect(new Rect(TextureRect.x - 1, TextureRect.y + TextureRect.height, TextureRect.width + 1, 1), color);
			// Left
			EditorGUI.DrawRect(new Rect(TextureRect.x - 1, TextureRect.y, 1, TextureRect.height), color);
		}

		/// <summary>
		/// Update the canvas frame.
		/// Set the originalWidth and height in case `frame` has been upsampled.
		/// </summary>
		public void SetFrame(Texture frame, int? originalWidth = null, int? originalHeight = null)
		{
			if (frame == null)
			{
				Frame = null;
			}
			else
			{
				Frame = frame;
				OriginalFrameWidth = originalWidth ?? frame.width;
				OriginalFrameHeight = originalHeight ?? frame.height;
			}
			
			DirtyDrawBuffer = true;
			Invalidate();
		}
    }
}