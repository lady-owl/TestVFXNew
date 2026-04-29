using System.Collections;
using UnityEditor;

namespace Tuatara.TFlow.Editor.Utils
{
    /// <summary>
    /// Start and finish a coroutine in the editor.
    /// </summary>
    public class EditorCoroutine
    {
        private IEnumerator Coroutine { get; set; }

        public EditorCoroutine(IEnumerator coroutine)
        {
            Coroutine = WaitFor(coroutine);
            EditorApplication.update += UpdateCoroutine;
        }

        private IEnumerator WaitFor(IEnumerator coroutine)
        {
            while (coroutine.MoveNext())
            {
                yield return null;
            }
            
            Coroutine = null;
        }

        private void UpdateCoroutine()
        {
            if (Coroutine != null)
            {
                Coroutine.MoveNext();
            }
            else
            {
                EditorApplication.update -= UpdateCoroutine;
            }
        }
    }
}