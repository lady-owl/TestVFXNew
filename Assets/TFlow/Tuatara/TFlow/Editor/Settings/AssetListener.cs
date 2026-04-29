using System;

namespace Tuatara.TFlow.Editor.Settings
{
    /// <summary>
    /// Create a Updated/Deleted listener for an asset at a specicif path.
    /// It listens to changes on the asset file or its .meta file.
    /// </summary>
    public class AssetListener
    {
        public string AssetPath { get; set; }

        public event Action OnAssetDeleted;
        public event Action OnAssetEdited;

        public AssetListener()
        {
            AssetPostprocessorListener.OnAssetDeleted += AssetPostprocessorListenerOnOnAssetDeleted;
            AssetPostprocessorListener.OnAssetEdited += AssetPostprocessorListenerOnOnAssetEdited; 
        }

        private void AssetPostprocessorListenerOnOnAssetEdited(string path)
        {
            if (path == AssetPath)
            {
                OnAssetEdited?.Invoke();
            }
        }

        private void AssetPostprocessorListenerOnOnAssetDeleted(string path)
        {
            if (path == AssetPath)
            {
                OnAssetDeleted?.Invoke();
            }
        }

        ~AssetListener()
        {
            AssetPostprocessorListener.OnAssetDeleted -= AssetPostprocessorListenerOnOnAssetDeleted;
            AssetPostprocessorListener.OnAssetEdited -= AssetPostprocessorListenerOnOnAssetEdited; 
        }
    }
}