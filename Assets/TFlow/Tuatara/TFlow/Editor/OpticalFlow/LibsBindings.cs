using System;
using System.Runtime.InteropServices;
using System.Text;
using UnityEngine;
using UnityEngine.Experimental.Rendering;

namespace Tuatara.TFlow.Editor.OpticalFlow
{
    public static class LibsBindings
    {
        private const string Libname = "optical-flow-baker";

        /// <summary>
        /// OpenCV Mat possible depths for an image.
        /// </summary>
        enum CvMatDepth
        {
            /// <summary>
            /// 8 bit unsigned
            /// </summary>
            CV_8U = 0,
            /// <summary>
            /// 8 bit signed
            /// </summary>
            CV_8S = 1,
            CV_16U = 2,
            CV_16S = 3,
            CV_32S = 4,
            /// <summary>
            /// 32 bits float
            /// </summary>
            CV_32F = 5,
            CV_64F = 6,
            CV_16F = 7,
        }

        /// <summary>
        /// Some used opencv flags
        /// </summary>
        public enum CvFlags
        {
            OPTFLOW_FARNEBACK_GAUSSIAN = 256
        }

        [DllImport(Libname, EntryPoint = "get_lib_version")]
        private static extern void _get_lib_version(byte[] buffer, int length);

        [DllImport(Libname, EntryPoint = "get_opencv_version")]
        private static extern void _get_opencv_version(byte[] buffer, int length);

        [DllImport(Libname, EntryPoint = "raw_texture_data_to_mat")]
        private static extern IntPtr _raw_texture_data_to_mat(IntPtr textureData, int width, int height, int channelCount, CvMatDepth depth);

        [DllImport(Libname, EntryPoint = "mat_to_raw_texture_data")]
        private static extern IntPtr _mat_to_raw_texture_data(IntPtr mat);

        [DllImport(Libname, EntryPoint = "free_mat")]
        private static extern IntPtr _free_mat(IntPtr mat);

        [DllImport(Libname, EntryPoint = "get_mat_width")]
        private static extern int _get_mat_width(IntPtr mat);

        [DllImport(Libname, EntryPoint = "get_mat_height")]
        private static extern int _get_mat_height(IntPtr mat);

        [DllImport(Libname, EntryPoint = "get_mat_channel_count")]
        private static extern int _get_mat_channel_count(IntPtr mat);

        [DllImport(Libname, EntryPoint = "get_mat_depth")]
        private static extern CvMatDepth _get_mat_depth(IntPtr mat);

        [DllImport(Libname, EntryPoint = "get_mat_byte_count")]
        private static extern int _get_mat_byte_count(IntPtr mat);
        
        [DllImport(Libname, EntryPoint = "bake_dense_optical_flow")]
        public static extern IntPtr _bake_dense_optical_flow(IntPtr previous, IntPtr next, int input_downsample, int output_downsample, int serch_size, bool invert_red, bool invert_green, float ocv_pyr_scale, int ocv_levels, int ocv_iterations, int ocv_polyn, float ocv_polysigma, int ocv_flags);

        public static string GetLibVersion()
        {
            var buffer = new byte[100];
            _get_lib_version(buffer, buffer.Length);
            return NativePluginUtils.CleanupString(Encoding.ASCII.GetString(buffer));
        }
        
        public static string GetOpenCVVersion()
        {
            var buffer = new byte[100];
            _get_opencv_version(buffer, buffer.Length);
            return NativePluginUtils.CleanupString(Encoding.ASCII.GetString(buffer));
        }

        public static IntPtr ConvertTextureToMat(Texture2D texture)
        {
            // Other formats are not supported.
            Debug.Assert(texture.format == TextureFormat.ARGB32
                         || texture.format == TextureFormat.RGBAFloat
                         || texture.format == TextureFormat.RGBAHalf);
            var data = texture.GetRawTextureData();
            var arrayHandle = GCHandle.Alloc(data, GCHandleType.Pinned);
            var dataAddr = arrayHandle.AddrOfPinnedObject();
            var depth =
                texture.format == TextureFormat.RGBAFloat ? CvMatDepth.CV_32F :
                texture.format == TextureFormat.RGBAHalf ? CvMatDepth.CV_16F :
                texture.format == TextureFormat.ARGB32 ? CvMatDepth.CV_8U :
                CvMatDepth.CV_8U;
            var mat = _raw_texture_data_to_mat(dataAddr, texture.width, texture.height, 4, depth);
            // Debug.Log($"Texture format: {texture.format}\n" +
            //           $"Raw texture data byte count: {data.Length}\n" +
            //           $"Mat byte count: {_get_mat_byte_count(mat)}\n" +
            //           $"W,H={texture.width}, {texture.height}\n" +
            //           $"C={GraphicsFormatUtility.GetComponentCount(texture.graphicsFormat)}\n" +
            //           $"C size={GraphicsFormatUtility.GetBlockSize(texture.graphicsFormat)}\n" +
            //           $"WxHxCxCSize={texture.width*texture.height*GraphicsFormatUtility.GetComponentCount(texture.graphicsFormat)*GraphicsFormatUtility.GetBlockSize(texture.graphicsFormat)/4}\n" +
            //           $"");
            Debug.Assert(_get_mat_byte_count(mat) == data.Length);
            
            arrayHandle.Free();
            return mat;
        }

        public static Texture2D ConvertMatToTexture2d(IntPtr mat, bool deleteMat, bool? linear = null)
        {
            Debug.Assert(mat != IntPtr.Zero);

            var dataSize = _get_mat_byte_count(mat);
            Debug.Assert(dataSize > 0);
            var data = _mat_to_raw_texture_data(mat);

            var w = _get_mat_width(mat);
            var h = _get_mat_height(mat);
            var channelCount = _get_mat_channel_count(mat);
            Debug.Assert(channelCount == 4); // Other combinaison are not supported
            var depth = _get_mat_depth(mat);
            // Supported mat formats are directly related to the input formats that we support in ConvertTextureToMat.
            // Other are not supported.
            Debug.Assert(depth == CvMatDepth.CV_8U
                         || depth == CvMatDepth.CV_16F
                         || depth == CvMatDepth.CV_32F);

            var outputFormat =
                depth == CvMatDepth.CV_32F ? TextureFormat.RGBAFloat :
                depth == CvMatDepth.CV_16F ? TextureFormat.RGBAHalf :
                TextureFormat.ARGB32;
            linear = linear ?? outputFormat != TextureFormat.ARGB32;
            
            var output = new Texture2D(w, h, outputFormat, false, linear.Value);
            output.LoadRawTextureData(data, dataSize);
            output.Apply();

            if (deleteMat)
            {
                _free_mat(mat);
            }

            return output;
        }

        public static void FreeMat(IntPtr mat)
        {
            Debug.Assert(mat != IntPtr.Zero);
            _free_mat(mat);
        }
    }
}