using UnityEngine;

namespace Tuatara.TFlow.Editor.Utils
{
    public static class UnityDestroyUtils
    {
        public static void Destroy(this Texture texture)
        {
            if (texture == null)
            {
                return;
            }

            (texture as Object).Destroy();
        }
        
        public static void Destroy(this Object entity)
        {
            if (entity == null)
            {
                return;
            }

            if (Application.isEditor)
            {
                Object.DestroyImmediate(entity, true);
            }
            else
            {
                Object.Destroy(entity);
            }
        }
    }
}