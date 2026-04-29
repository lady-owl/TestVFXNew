namespace Tuatara.TFlow.Editor.OpticalFlow
{
    public static class NativePluginUtils
    {
        /// <summary>
        /// Remove \0 null-terminated char from a string that was created with a Native Plugin.
        /// </summary>
        public static string CleanupString(string str)
        {
            var pos = str.IndexOf('\0');
            if (pos >= 0)
            {
                return str.Substring(0, pos);
            }

            return str;
        }
    }
}