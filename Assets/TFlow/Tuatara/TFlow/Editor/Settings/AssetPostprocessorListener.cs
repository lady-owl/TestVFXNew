using System;
using UnityEditor;

namespace Tuatara.TFlow.Editor.Settings
{
    /// <summary>
    /// Provide event to know when an asset is edited.
    /// </summary>
    public class AssetPostprocessorListener : AssetPostprocessor
    {
        public static event Action<string> OnAssetEdited;
        public static event Action<string> OnAssetDeleted;

        private static void OnPostprocessAllAssets(string[] importedAssets, string[] deletedAssets, string[] movedAssets, string[] movedFromAssetPaths)
        {
            if (OnAssetEdited != null)
            {
                foreach (var path in importedAssets)
                {
                    OnAssetEdited?.Invoke(path);
                }
            }

            if (OnAssetDeleted != null)
            {
                foreach (var path in deletedAssets)
                {
                    OnAssetDeleted?.Invoke(path);
                }
                
                // At the moment, we consider moved assets as deleted.
                foreach (var path in movedFromAssetPaths)
                {
                    OnAssetDeleted?.Invoke(path);
                }
                foreach (var path in movedAssets)
                {
                    OnAssetDeleted?.Invoke(path);
                }
            }
        }
    }
}