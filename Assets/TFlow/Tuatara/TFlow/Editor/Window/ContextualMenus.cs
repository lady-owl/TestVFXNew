using System.Globalization;
using Tuatara.TFlow.Editor.Utils;
using UnityEditor;
using UnityEngine;
using UnityEngine.Experimental.Rendering;

namespace Tuatara.TFlow.Editor.Window
{
    /// <summary>
    /// Unity menu entries to open and use TFlow.
    /// </summary>
    public static class ContextualMenus
    {
        //
        // Unity top menu actions.
        //
        
        [MenuItem("Window/Tuatara/TFlow")]
        public static void OpenEditor()
        {
            TFlowWindow.Open();
        }
        
        //
        // Unity assets actions.
        //
        
        /// <summary>
        /// Open OpticalFlow Baker for the selected texture with a right click menu 
        /// </summary>
        [MenuItem("Assets/Tuatara/Open TFlow")]
        private static void OpenTFlow()
        {
			Texture2D selectedTexture = null;
			if (Selection.objects.Length == 1 && Selection.activeObject != null && Selection.activeObject is Texture2D)
			{ selectedTexture = (Texture2D)Selection.activeObject; }
			TFlowWindow.Open(selectedTexture);
        }

        /// <summary>
        /// Callback to enable the right click menu item
        /// </summary>
        [MenuItem("Assets/Tuatara/Open TFlow", true)]
        private static bool ShouldShowOpenTFlow()
        {
            return true;
        }
        
        [MenuItem("Assets/Tuatara/Copy Motion Intensity into Clipboard")]
        private static void GetAndDecodeMotionIntensity()
        {
            var texture = (Texture2D) Selection.activeObject;
            Debug.Assert(texture != null);

            var motionIntensity = GetAndDecodeMotionIntensity(texture);

            GUIUtility.systemCopyBuffer = motionIntensity.ToString(CultureInfo.InvariantCulture);
            Debug.Log($"Motion intensity {motionIntensity} copied into the clipboard.");
        }

        [MenuItem("Assets/Tuatara/Copy Motion Intensity into Clipboard", true)]
        private static bool ShouldGetAndDecodeMotionIntensity()
        {
            return Selection.objects.Length == 1
                   && Selection.activeObject != null
                   && Selection.activeObject is Texture2D;
        }

        private static float GetAndDecodeMotionIntensity(Texture2D texture)
        {
            //=> Try to find the motion intensity in the name.
            var nameMotionIntensity = RegexUtils.ParseMotionIntensityFromName(texture.name);
            if (nameMotionIntensity.HasValue)
            {
                return nameMotionIntensity.Value;
            }

            //=> Otherwise decode it from the blue and alpha channel.
            var readableTexture = TextureUtils.ToReadableTexture(texture);
            Debug.Assert(!GraphicsFormatUtility.IsSRGBFormat(readableTexture.graphicsFormat));
            
            var col = readableTexture.GetPixel(0, 0);
            var encMotionIntensity = new Vector2(col.b, col.a);
            var motionIntensity = EncodingUtils.DecodeRGTo16bits(encMotionIntensity);

            if (readableTexture != texture)
            {
                readableTexture.Destroy();
            }

            return motionIntensity;
        }
    }
}