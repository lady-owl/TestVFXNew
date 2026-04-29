using System;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Utils
{
    public static class VectorUtils
    {
        public static Vector2 Frac(Vector2 value)
        {
            return new Vector2(Frac(value.x), Frac(value.y));
        }
        
        public static float Frac(float value)
        {
            return (float) Frac((decimal) value);
        }
        
        public static decimal Frac(decimal value)
        {
            return value - Math.Truncate(value);
        }
    }
}