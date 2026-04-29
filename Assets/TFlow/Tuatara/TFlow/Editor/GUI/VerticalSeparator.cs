using UnityEditor;
using UnityEngine;

namespace Tuatara.TFlow.Editor.GUI
{
    /// <summary>
    /// Vertical separator that splits two GUI in an Editor window.
    /// The separator position can be adjusted by the user.
    /// Left and right content is drawn using a delegate.
    /// </summary>
    public class VerticalSeparator
    {
        public delegate void OnGUIDelegate(Rect drawRect);

        public float SeparatorPosition { get; private set; } = 350f;
        private Vector2 SeparatorPositionMinMax { get; } = new Vector2(350, 450);
        private bool IsResizing { get; set; }

        /// <summary>
        /// Draw the separator with its left and right sides. 
        /// </summary>
        /// <returns>True if the separator is moving</returns>
        public bool OnGUI(Rect rect, float rightMarginBottom, OnGUIDelegate leftContent, OnGUIDelegate rightContent)
        {
            leftContent?.Invoke(new Rect(rect.x, rect.y, SeparatorPosition, rect.height));
            rightContent?.Invoke(new Rect(rect.x + SeparatorPosition, rect.y, rect.width - SeparatorPosition, rect.height - rightMarginBottom));
            
            HandleSeparatorTranslation(rect);

            return IsResizing;
        }
        
        private void HandleSeparatorTranslation(Rect rect)
        {
            var resizeActiveArea = new Rect(rect.x + SeparatorPosition - 8, rect.y, 16, rect.height);
            EditorGUIUtility.AddCursorRect(resizeActiveArea, MouseCursor.ResizeHorizontal);

            if (Event.current.type == EventType.MouseDown && resizeActiveArea.Contains(Event.current.mousePosition))
                IsResizing = true;

            if (IsResizing)
            {
                SeparatorPosition = Event.current.mousePosition.x;
            }

            SeparatorPosition = Mathf.Clamp(
                SeparatorPosition, 
                SeparatorPositionMinMax.x, 
                SeparatorPositionMinMax.y);

            // Draw a line for the separator
            var offset = new RectOffset(7, 8, 0, 0);
            EditorGUI.DrawRect(offset.Remove(resizeActiveArea), new Color(0, 0, 0, 0.5f));
            
            if (Event.current.type == EventType.MouseUp) IsResizing = false;
        }
    }
}