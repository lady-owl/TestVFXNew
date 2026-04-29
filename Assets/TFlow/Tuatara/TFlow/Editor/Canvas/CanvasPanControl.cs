using UnityEditor;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Canvas
{
    public class CanvasPanControl
    {
		public Vector2 Position { get; private set; } = Vector2.zero;
        private PreviewCanvas Canvas { get; }
        
        private bool IsDraging { get; set; } = false;

        public CanvasPanControl(PreviewCanvas canvas)
        {
            Canvas = canvas;
        }

		public void Reset()
		{
			Position = Vector2.zero;
		}

        public void HandlePanControl(Rect canvasRect)
        {
            // Pan with Alt+right click or middle mouse button
            var startDrag = 
                Event.current.type == EventType.MouseDown &&
                (Event.current.button == 2
                 || Event.current.button == 0 && Event.current.alt);
            if (startDrag)
            {
                IsDraging = true;
            }
            
            var stopDrag =
                (Event.current.rawType == EventType.MouseUp || Event.current.rawType == EventType.DragExited) &&
                (Event.current.button == 2 || Event.current.button == 0);
            if (stopDrag)
            {
                IsDraging = false; // drag should not be true, but we never know
                Canvas.Draw();
            }
            
            // Show a pan mouse cursor
            if (!IsDraging && Event.current.alt || IsDraging)
            {
                EditorGUIUtility.AddCursorRect(canvasRect, MouseCursor.Pan);
                Canvas.Draw();
            }

            // Apply drag.
            if (IsDraging && Event.current.type == EventType.MouseDrag)
            {
                Position -= Event.current.delta;
                Canvas.Draw();
            }
        }

        public void OverridePosition(Vector2 newPosition)
        {
            Position = newPosition;
        }
    }
}