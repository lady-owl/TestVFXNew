using System;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Utils
{
    public static class RegexUtils
    {
        /// <summary>
        /// Try to parse a flipbook size (row count, column count) from a name.
        /// "10x2_Name" will return (10, 2).
        /// </summary>
        public static Vector2Int? ParseFlipbookSizeFromName(string name)
        {
            var result = Regex.Matches(
                name,
                "([0-9]+)x([0-9]+)").Cast<Match>().ToList();

            if (result.Count <= 0 || result[0].Groups.Count != 3)
            {
                return null;
            }

            var firstMatch = result[0];
            if (int.TryParse(firstMatch.Groups[1].Value, out var width)
                && int.TryParse(firstMatch.Groups[2].Value, out var height))
            {
                return new Vector2Int(width, height);
            }

            return null;
        }
        
        /// <summary>
        /// Try to parse the motion intensity from the name "_Intensity-05234" becomes 0.05234
        /// </summary>
        public static float? ParseMotionIntensityFromName(string name)
        {
            var motionIntensityPrefix = "_Intensity-";
            if (!name.Contains(motionIntensityPrefix))
            {
                return null;
            }

            var prefixPos = name.IndexOf(motionIntensityPrefix, StringComparison.Ordinal);
            // FILENAME_Intensity-01234-SOMETHING => 01234-SOMETHING
            var motionIntensityPart = name.Substring(
                prefixPos + motionIntensityPrefix.Length, 
                name.Length - motionIntensityPrefix.Length - prefixPos);
            
            // 01234-SOMETHING => 01234
            var result = Regex.Matches(
                motionIntensityPart,
                "([0-9]+)").Cast<Match>().ToList();

            if (result.Count <= 0 || result[0].Groups.Count != 2)
            {
                return null;
            }

            var digits = result[0].Groups[1].Value;
            var ci = (CultureInfo)CultureInfo.CurrentCulture.Clone();
            ci.NumberFormat.CurrencyDecimalSeparator = ".";
            // 01234 => 0.01234
            if (!float.TryParse($"0.{digits}", NumberStyles.Any, ci, out var motionIntensity))
            {
                return null;
            }

            return motionIntensity;
        }
        
        // https://docs.microsoft.com/en-us/dotnet/standard/base-types/how-to-strip-invalid-characters-from-a-string
        public static string CleanInput(string strIn)
        {
            // Replace invalid characters with empty strings.
            try {
                return Regex.Replace(strIn, @"[^\w\.@-]", "",
                    RegexOptions.None, TimeSpan.FromSeconds(1.5));
            }
            // If we timeout when replacing invalid characters,
            // we should return Empty.
            catch (RegexMatchTimeoutException) {
                return String.Empty;
            }
        }
        
    }
}