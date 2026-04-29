namespace Tuatara.TFlow.Editor.Utils
{
    public static class MathUtils
    {
        public static bool IsPowerOfTwo(int x)
        {
            return (x != 0) && ((x & (x - 1)) == 0);
        }   
    }
}