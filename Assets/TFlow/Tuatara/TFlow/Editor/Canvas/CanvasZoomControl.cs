using UnityEngine;

namespace Tuatara.TFlow.Editor.Canvas
{
    /// <summary>
    /// Logic for zooming in/out of the canvas.
    /// </summary>
    public class CanvasZoomControl
    {
		private const float ZOOM_DEFAULT = 1.0f;
        private PreviewCanvas Canvas { get; }
        private CanvasPanControl PanControl { get; }
        
        public float Zoom { get; private set; } = ZOOM_DEFAULT;
        public float ZoomPercent => Zoom * 100f;

        private Vector2 ZoomMinMax { get; } = new Vector2(0.2f, 10.0f);
        
		public void Reset()
		{
			Zoom = ZOOM_DEFAULT;
		}

        public CanvasZoomControl(PreviewCanvas canvas, CanvasPanControl canvasPanControl)
        {
            Canvas = canvas;
            PanControl = canvasPanControl;
        }

        public void HandleZoomControl(Rect canvasRect)
        {
            // Zoom with the mouse wheel
            if (Event.current.type == EventType.ScrollWheel && canvasRect.Contains(Event.current.mousePosition))
            {
                // Delta negative when zooming In, Positive when zooming out
                var speed = 0.05f;
                var zoomDelta = Event.current.delta.y * speed;
                var zoomCenter = Event.current.mousePosition;

                var centerPos =
                    -new Vector2(zoomCenter.x - canvasRect.width / 2, zoomCenter.y - canvasRect.height / 2) 
                    -PanControl.Position;
                var prevZoom = Zoom;

                Zoom -= zoomDelta;

                if (Zoom < ZoomMinMax.x) Zoom = ZoomMinMax.x;
                else if (Zoom > ZoomMinMax.y) Zoom = ZoomMinMax.y;
                else
                {
                    var panOffset = centerPos - ((Zoom / prevZoom) * centerPos);
                    var newPanPosition = PanControl.Position + panOffset;
                    PanControl.OverridePosition(newPanPosition);
                }

                Canvas.Draw();
            }
        }
    }
}