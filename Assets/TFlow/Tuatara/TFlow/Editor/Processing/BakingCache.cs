using System.Collections.Generic;
using System.Collections.ObjectModel;
using Tuatara.TFlow.Editor.Utils;
using UnityEngine;

namespace Tuatara.TFlow.Editor.Processing
{
    /// <summary>
    /// Just a list of frames of a specific size that can be destroyed. 
    /// </summary>
    public class BakingCache
    {
        public List<Texture2D> Frames { get; private set; }

        public int Length => Frames.Count;

        public Texture2D this[int index]
        {
            get
            {
                Debug.Assert(index >= 0);
                Debug.Assert(Frames.Count > index);
                return Frames[index];
            }

            set
            {
                Debug.Assert(index >= 0);
                Debug.Assert(Frames.Count > index);
                Debug.Assert(Frames[index] == null); // frame already baked, not supported, memory loss
                Frames[index] = value;
            }
        }

        public BakingCache()
        {
            Frames = new List<Texture2D>();
        }

        public void Init(int frameCount)
        {
            if (Frames.Count == frameCount)
            {
                return; // Already ready.
            }
            Debug.Assert(Frames.Count == 0); // If not, then we have a memory leak :)

            if (frameCount > 0)
            {
                // Fill the baked frames with nulls.
                Frames = new List<Texture2D>(new Texture2D[frameCount]);
            }
            else
            {
                Frames = new List<Texture2D>();
            }
        }

        public bool IsSequenceBaked()
        {
            for (var i = 0; i < Frames.Count; i++)
            {
                if (!IsFrameBaked(i))
                {
                    return false;
                }
            }

            return true;
        }

        public bool IsFrameBaked(int frameIndex)
        {
            var motionVectorsBaked = Frames.Count > frameIndex && Frames[frameIndex] != null;
            return motionVectorsBaked;
        }
        
        public void Clear()
        {
            foreach (var frame in Frames)
            {
                frame.Destroy();
            }

            Frames.Clear();
        }
    }
}