using UnityEngine;

namespace Tuatara.TFlow.Editor.GUI
{
    /// <summary>
    /// Vertical separator that splits two GUI in an Editor window.
    /// The separator position can be adjusted by the user.
    /// Left and right content is drawn using a delegate.
    /// </summary>
    public class HorizontalSeparator
    {
		static public GUIStyle Style;

		public HorizontalSeparator()
		{
			if (Style == null)
			{
				Style = new GUIStyle("sv_iconselector_sep");
				Style.margin = new RectOffset(0, 0, 8, 0);
			}
		}

		/// <summary>
		/// Draw the separator.
		/// </summary>
		public void Draw()
		{
			GUILayout.Label(GUIContent.none, Style);
		}
	}
}