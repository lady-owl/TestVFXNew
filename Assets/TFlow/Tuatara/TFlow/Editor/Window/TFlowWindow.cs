using Tuatara.TFlow.Editor.Canvas;
using Tuatara.TFlow.Editor.GUI;
using Tuatara.TFlow.Editor.Playback;
using Tuatara.TFlow.Editor.Processing;
using Tuatara.TFlow.Editor.Settings;
using UnityEditor;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Window
{
    /// <summary>
    /// Main window for OpticalFlow Baker tool.
    /// </summary>
    public class TFlowWindow : EditorWindow
    {
        private bool Dirty { get; set; }

		[field: SerializeField]
		public SettingsModel Settings { get; private set; }

		/// <summary>
        /// Splits the left panel (settings) and the right panel (canvas).
        /// </summary>
        public VerticalSeparator Separator { get; private set; }

		public SettingsController SettingsController { get; private set; }

		private PreviewCanvas Canvas { get; set; }

        public GlobalProcessingController GlobalProcessingController { get; private set; }

        /// <summary>
        /// Logic for playing, stopping the flipbook animation.
        /// </summary>
        public PlaybackController PlaybackController { get; private set; }
        
        /// <summary>
        /// Logic for exporting and writing files.
        /// </summary>
        public ExportController ExportController { get; private set; }
        
        private Toolbar Toolbar { get; set; }
        private PlaybackView Playback { get; set; }
        
        private SettingsSidebar SettingsSidebar { get; set; }

		private Texture2D WindowTitleIcon { get; set; }

		private Texture2D SelectionActiveSelectedTexture { get; set; }

		public static void Open(Texture2D texture = null)
        {
			TFlowWindow window = GetWindow(typeof(TFlowWindow)) as TFlowWindow;
			window.SelectionActiveSelectedTexture = texture;
		}

		/// <summary>
		/// Unity OnEnable.
		/// </summary>
		private void OnEnable()
		{
			Undo.undoRedoPerformed += OnUndoRedo;
			AssemblyReloadEvents.beforeAssemblyReload += OnBeforeAssemblyReload;
			AssemblyReloadEvents.afterAssemblyReload += OnAfterAssemblyReload;

			WindowTitleIcon = Resources.Load<Texture2D>("Icons/Tuatara_Small");

			titleContent = new GUIContent(GlobalGUIContent.WindowTitle, WindowTitleIcon);
			minSize = new Vector2(900, 400);
		}

        private void OnDisable()
        {
	        Undo.ClearUndo(this);
	        Undo.undoRedoPerformed -= OnUndoRedo;
	        AssemblyReloadEvents.beforeAssemblyReload -= OnBeforeAssemblyReload;
	        AssemblyReloadEvents.afterAssemblyReload -= OnAfterAssemblyReload;

			Resources.UnloadAsset(WindowTitleIcon);
			WindowTitleIcon = null;
		}

		public void Invalidate()
        {
            Dirty = true;
        }

        private void OnGUI()
        {
	        InitializeGUI();
            Dirty = false;

            // Draw the bottom toolbar.
            Toolbar.OnGUI();
			// Draw the bottom playback.
			Playback.OnGUI();

			// Draw the settings panel, the separator and the canvas.
			// The separator will trigger drawing of the settings and the canvas.
			var drawArea = new Rect(0, 0, position.width, position.height);
            var separatorMoved = Separator.OnGUI(drawArea, Toolbar.Height + Playback.Height, SettingsSidebar.OnGUI, Canvas.OnGUI);
            
            if (separatorMoved)
            {
                Invalidate();
            }

            if (Dirty)
            {
                Repaint();
            }
        }

        private void InitializeGUI()
        {
	        Settings = Settings ?? new SettingsModel();
	        SettingsController = SettingsController ?? new SettingsController(this);
            Canvas = Canvas ?? new PreviewCanvas(this);
            Separator = Separator ?? new VerticalSeparator();
            GlobalProcessingController = GlobalProcessingController ?? new GlobalProcessingController(this, Canvas);
            Toolbar = Toolbar ?? new Toolbar(this, Canvas);
			Playback = Playback ?? new PlaybackView(this, Canvas);
            SettingsSidebar = SettingsSidebar ?? new SettingsSidebar(this);
            PlaybackController = PlaybackController ?? new PlaybackController(this);
            ExportController = ExportController ?? new ExportController(this);

			if (SelectionActiveSelectedTexture != null)
			{
				SettingsController.Input.ChangeFlipbook(SelectionActiveSelectedTexture);
				SelectionActiveSelectedTexture = null;
			}
		}

        public void DisplayLoadingCursor()
        {
	        try {
		        EditorGUIUtility.AddCursorRect(
			        new Rect(0, 0, Screen.width, Screen.height), 
			        MouseCursor.FPS);
	        }
	        catch
	        {
		        // ignored
		        // NPE is thrown when invalidating the flipbook when updating the asset from unity.
	        }
        }

        /// <summary>
		/// Undo and Redo callback.
		/// </summary>
		private void OnUndoRedo()
		{
			SettingsController?.Invalidate();
			Invalidate();
			if (Settings != null && GlobalProcessingController != null)
			{
				GlobalProcessingController.Invalidate(GlobalProcessingController.InvalidateType.All);
			}
		}

		/// <summary>
		/// Clear it all when reloading the assemblies.
		/// </summary>
		private void OnBeforeAssemblyReload()
		{
			Undo.ClearUndo(this);
			if (Settings == null)
			{
				return;
			}

			if (Canvas != null)
			{
				Canvas.Destroy();
				Canvas = null;
			}

			if (GlobalProcessingController != null)
			{
				GlobalProcessingController.Destroy();
				GlobalProcessingController = null;
			}
		}

		private void OnAfterAssemblyReload()
		{
			Undo.ClearUndo(this);
			SettingsController?.Invalidate();
			Invalidate();
		}

		/// <summary>
		/// Unity OnDestroy.
		/// </summary>
		private void OnDestroy()
		{
			Undo.ClearUndo(this);
			AssemblyReloadEvents.beforeAssemblyReload -= OnBeforeAssemblyReload;
			AssemblyReloadEvents.afterAssemblyReload -= OnAfterAssemblyReload;
			Undo.undoRedoPerformed -= OnUndoRedo;
			GlobalProcessingController?.Dispose();
		}
    }
}