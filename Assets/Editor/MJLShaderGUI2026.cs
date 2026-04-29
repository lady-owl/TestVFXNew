using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;//使用GUI所必须的

/*
Edited by MJL 
*FileName: MJLShaderGUI2026.cs
*Author: MJLKids
*Date:  2026/
*UnityVersion:  2023.3.0a17
*/

public class MJLShaderGUI2026 : ShaderGUI
{
    #region 折叠状态，最大的层级
    // 折叠状态（Editor-only）
    private static bool showBaseSettings = true;
    private static bool showMainTexSettings = true;
    private static bool showNoiseTexSettings = true;
    private static bool showAddTexSettings = true;
    private static bool showMultiTexSettings = true;
    private static bool showDisTexSettings = true;
    private static bool showFresnelSettings = true;
    private static bool showVOSettings = true;



    #endregion
    #region 定义基础属性
    #region 定义枚举变量
    private MaterialProperty srcMode;
    private MaterialProperty dstMode;
    private MaterialProperty cullMode;
    private MaterialProperty zTestMode;
    private enum SrcMode
    {
        Zero = 0,
        One = 1,
        DstColor = 2,
        SrcColor = 3,
        OneMinusDstColor = 4,
        SrcAlpha = 5,
        OneMinusSrcColor = 6,
        DstAlpha = 7,
        OneMinusDstAlpha = 8,
        SrcAlphaSaturate = 9,
        OneMinusSrcAlpha = 10
    }
    private enum DstMode
    {
        Zero = 0,
        One = 1,
        DstColor = 2,
        SrcColor = 3,
        OneMinusDstColor = 4,
        SrcAlpha = 5,
        OneMinusSrcColor = 6,
        DstAlpha = 7,
        OneMinusDstAlpha = 8,
        SrcAlphaSaturate = 9,
        OneMinusSrcAlpha = 10
    }
    private enum CullMode
    {
        Off= 0,
        Front=1,
        Back= 2
    }
    private enum ZTestMode 
    { 
        Disabled =0,
        Never=1,
        Less=2,
        Equal=3,
        LessEqual=4,
        Greater=5,
        NotEqual=6,
        GreaterEqual =7,
        Always =8
    }

    #endregion
    // 定义一个 Editor 用的枚举
    #region 定义float变量
    private MaterialProperty softParticle;
    private MaterialProperty alphaMulti;
    private MaterialProperty enableCustomdata;
    private MaterialProperty enableAddChannelA;
    private MaterialProperty reverseSoftParticle;
    private MaterialProperty enableMixfresnel;


    //定义功能是否开启
    private MaterialProperty enableNoise;
    private MaterialProperty enableAddTex;
    private MaterialProperty enableMaskTex;
    private MaterialProperty enableDissolve;


    #endregion
    #endregion


    #region 定义主纹理属性
    // 定义主贴图缓存属性
    //这里只是定义参数，在ONGUI中抓取对应参数
    private MaterialProperty customOption;
    private MaterialProperty mainTexTO;
    private MaterialProperty mainTexUVMode;
    private MaterialProperty mainTexSpeedX;
    private MaterialProperty mainTexSpeedY;
    private MaterialProperty noiseToMain;
    private MaterialProperty mainTex;
    private MaterialProperty mainTexColor;

    //定义色相差参数
    private MaterialProperty enableCausticsOn;
    private MaterialProperty causticsColor1;
    private MaterialProperty causticsColor1Move;
    private MaterialProperty causticsColor2;
    private MaterialProperty causticsColor2Move;
    private MaterialProperty causticsColor3;
    private MaterialProperty causticsColor3Move;
    private MaterialProperty noiseToCaustics;
    private MaterialProperty noiseToCaustics2;
    private MaterialProperty noiseToCaustics3;
    private MaterialProperty colorStrength;




    // 定义扭曲贴图缓存属性
    private MaterialProperty noiseTex;
    private MaterialProperty noiseStr;
    private MaterialProperty noiseTexTO;
    private MaterialProperty noiseSpeedX;
    private MaterialProperty noiseSpeedY;
    private MaterialProperty noiseTexUVMode;
    

    //定义叠加贴图缓存属性
    private MaterialProperty addTex;
    private MaterialProperty addTexTO;
    private MaterialProperty addTexColor;
    private MaterialProperty addTexUVMode;
    private MaterialProperty noiseToAdd;
    private MaterialProperty addSpeedX;
    private MaterialProperty addSpeedY;

    // 定义相乘贴图缓存属性
    private MaterialProperty multiTex;
    private MaterialProperty grayToAlpha;
    private MaterialProperty multiTexColor;
    private MaterialProperty noiseToMulti;
    private MaterialProperty multiTexUVMode;
    private MaterialProperty multiStr;
    private MaterialProperty multiTexTO;
    private MaterialProperty multiSpeedX;
    private MaterialProperty multiSpeedY;

    // 定义溶解贴图缓存属性
    private MaterialProperty disTex;
    private MaterialProperty disUVMode;
    private MaterialProperty disAmount;
    private MaterialProperty disHard;
    private MaterialProperty disTexTO;
    private MaterialProperty disSpeedX;
    private MaterialProperty disSpeedY;
    private MaterialProperty noiseToDis;
    private MaterialProperty disEdgeColor;
    private MaterialProperty disEdgeSoft;


    // 定义菲涅尔设置缓存属性
    private MaterialProperty enableEdgeFade;
    private MaterialProperty enablereversalFade;
    private MaterialProperty angleFadePower;
    private MaterialProperty angleFadeStr;
    private MaterialProperty fresnelColor;

    // 定义顶点动画设置缓存属性
    private MaterialProperty enableVO;
    private MaterialProperty voVectorMask;
    private MaterialProperty enableNormalVO;
    private MaterialProperty normalVOStr;
    private MaterialProperty VOStr;
    private MaterialProperty voNoise;
    private MaterialProperty enableNoiseUV2;
    private MaterialProperty voTO;
    private MaterialProperty voNoiseSpeedX;
    private MaterialProperty voNoiseSpeedY;
    
    private MaterialProperty voCustomStr;
    private MaterialProperty singleStr;

    private MaterialProperty voCustomTO;

    // 定义顶点动画Mask缓存属性
    private MaterialProperty voMask;
    private MaterialProperty voMaskTO;
    private MaterialProperty voMaskSpeedX;
    private MaterialProperty voMaskSpeedY;
    private MaterialProperty enableVOMaskUV2;
    private MaterialProperty reverseVOMaskUV2;



    private enum CustomOption
    {
        NormalCustomON = 0,
        MeshUV2ON = 1
    }
    private enum MaintexUVMode
    {
        UV1 = 0,
        MeshUV2 = 1,
        EasyUV2=2,
        ScreenSpace=3
    }
    private enum NoisetexUVMode
    {
        UV1 = 0,
        MeshUV2 = 1,
        EasyUV2 = 2,
        ScreenSpace = 3
    }
    private enum AddTexUVMode
    {
        UV1 = 0,
        MeshUV2 = 1,
        EasyUV2 = 2,
        ScreenSpace = 3
    }
    private enum MultiTexUVMode
    {
        UV1 = 0,
        MeshUV2 = 1,
        EasyUV2 = 2,
        ScreenSpace = 3
    }
    private enum DisUVMode
    {
        UV1 = 0,
        MeshUV2 = 1,
        EasyUV2 = 2,
        ScreenSpace = 3
    }
    private enum VOVectorMask
    {
        X = 0,
        Y = 1,
        Z = 2
    }
    private enum VoCustomStr
    {
        W1 = 0,
        W2 = 1,
        None = 2
    }

    private enum VOCustomTO
    {
        X1WY2W = 0,
        X1W = 1,
        Y2W = 2,
        None = 3
    }


    #endregion

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        #region 抓参数！

        // 1. 从 Shader 的 Properties 中“抓”对应参数
        //此处的“”要和材质中的名称相同
        srcMode = FindProperty("_SrcMode", properties);
        dstMode = FindProperty("_DstMode", properties);
        cullMode = FindProperty("_CullMode", properties);
        zTestMode = FindProperty("_ZTestMode", properties);
        softParticle = FindProperty("_SoftParticle", properties);
        reverseSoftParticle = FindProperty("_ReverseSoftParticle", properties);
        enableMixfresnel = FindProperty("_EnableMixfresnel", properties);

        alphaMulti = FindProperty("_AlphaMulti", properties);
        customOption = FindProperty("_CustomOption", properties);
        enableCustomdata = FindProperty("_CustomON", properties);
        mainTex = FindProperty("_MainTex", properties);
        mainTexColor = FindProperty("_MainColor", properties);
        mainTexTO = FindProperty("_MainTexTO", properties);
        mainTexUVMode = FindProperty("_MaintexUVMode", properties);
        mainTexSpeedX = FindProperty("_MainTexSpeedX", properties);
        mainTexSpeedY = FindProperty("_MainTexSpeedY", properties);
        noiseToMain = FindProperty("_NoiseToMain", properties);
        noiseTex = FindProperty("_NoiseTex", properties);
        noiseStr = FindProperty("_NoiseStrength", properties);
        noiseTexTO = FindProperty("_NoiseTO", properties);
        noiseSpeedX = FindProperty("_NoiseTexSpeedX", properties);
        noiseSpeedY = FindProperty("_NoiseTexSpeedY", properties);
        noiseTexUVMode = FindProperty("_NoiseUVMode", properties);
        addTex = FindProperty("_AddTex", properties);
        enableAddChannelA = FindProperty("_SwitchAddChannelA", properties);
        addTexTO = FindProperty("_AddTexTO", properties);
        addTexColor = FindProperty("_AddTexColor", properties);
        addTexUVMode = FindProperty("_AddTexUVMode", properties);
        noiseToAdd = FindProperty("_NoisetoAdd", properties);
        addSpeedX = FindProperty("_AddTexSpeedX", properties);
        addSpeedY = FindProperty("_AddTexSpeedY", properties);
        multiTex = FindProperty("_MultiTex", properties);
        grayToAlpha = FindProperty("_grayToAlpha", properties);
        multiTexColor = FindProperty("_MultiColor", properties);
        noiseToMulti = FindProperty("_NoiseToMuti", properties);
        multiTexUVMode = FindProperty("_MultiTexUVMode", properties);
        multiStr = FindProperty("_MutiIntensity", properties);
        multiTexTO = FindProperty("_MultiTexTO", properties);
        multiSpeedX = FindProperty("_MutiTexSpeedX", properties);
        multiSpeedY = FindProperty("_MutiTexSpeedY", properties);
        disTex = FindProperty("_DisolveGuide", properties);
        disUVMode = FindProperty("_DisTexUVMode", properties);
        disAmount = FindProperty("_DissolveAmount", properties);
        disHard = FindProperty("_DisHard", properties);
        disSpeedX = FindProperty("_DisSpeedX", properties);
        disSpeedY = FindProperty("_DisSpeedY", properties);
        disTexTO = FindProperty("_DisTO", properties);
        noiseToDis = FindProperty("_NoiseToDis", properties);
        disEdgeColor = FindProperty("_DisEdgeColor", properties);
        disEdgeSoft = FindProperty("_DisEdgeSoft", properties);
        enablereversalFade = FindProperty("_ReversalFade", properties);
        enableEdgeFade = FindProperty("_AnglefadeOn", properties);
        angleFadePower = FindProperty("_AnglefadePower", properties);
        fresnelColor = FindProperty("_FresnelColor", properties);
        angleFadeStr = FindProperty("_AngleFadeStr", properties);
        enableVO = FindProperty("_EnableVO", properties);
        enableNormalVO = FindProperty("_UseNormal", properties);
        normalVOStr = FindProperty("_VONormalStr", properties);
        VOStr = FindProperty("_VibrantStr", properties);
        voVectorMask = FindProperty("_VOVectorMask", properties);
        voNoise = FindProperty("_VONoise", properties);
        voCustomStr = FindProperty("_MyVOCustomStr", properties);
        enableNoiseUV2 = FindProperty("_EnableNoiseUV2", properties);
        voTO = FindProperty("_VONoiseTO", properties);
        voNoiseSpeedX = FindProperty("_VONoiseSpeedX", properties);
        voNoiseSpeedY = FindProperty("_VONoiseSpeedY", properties);
        voCustomTO = FindProperty("_MyVOCustomTO", properties);
        voMask = FindProperty("_VOMask", properties);
        voMaskTO = FindProperty("_VOMaskTO", properties);
        voMaskSpeedX = FindProperty("_VOMaskSpeedX", properties);
        voMaskSpeedY = FindProperty("_VOMaskSpeedY", properties);
        enableVOMaskUV2 = FindProperty("_EnableMaskUV2", properties);
        reverseVOMaskUV2 = FindProperty("_SwitchMask", properties);
        singleStr = FindProperty("_SingleVector", properties);
        enableCausticsOn = FindProperty("_CausticsOn", properties);
        causticsColor1 = FindProperty("_CausticsColor1", properties);
        causticsColor1Move = FindProperty("_CausticsColor1Move", properties);
        causticsColor2 = FindProperty("_CausticsColor2", properties);
        causticsColor2Move = FindProperty("_CausticsColor2Move", properties);
        causticsColor3 = FindProperty("_CausticsColor3", properties);
        causticsColor3Move = FindProperty("_CausticsColor3Move", properties);
        noiseToCaustics = FindProperty("_NoiseToCaustics", properties);
        noiseToCaustics2 = FindProperty("_NoiseToCaustics2", properties);
        noiseToCaustics3 = FindProperty("_NoiseToCaustics3", properties);
        colorStrength = FindProperty("_ColorStrength", properties);


        enableNoise = FindProperty("_EnableNoise", properties);
        enableAddTex = FindProperty("_EnableAddTex", properties);
        enableMaskTex = FindProperty("_EnableMaskTex", properties);
        enableDissolve = FindProperty("_EnableDissolve", properties);




        #endregion
        // 2. 开始画 UI
        EditorGUILayout.LabelField("*FileName: MJLShaderGUI2026.cs *Author: MJLKids *UnityVersion:  2023.3.0a17", EditorStyles.boldLabel);//单独成一行的标题，是装饰元素

        #region 基础属性折叠
        // 折叠标题
        showBaseSettings = EditorGUILayout.Foldout(showBaseSettings, "基础参数", true);
        if (showBaseSettings)
        {
            // 缩进，让层级更清晰
            EditorGUI.indentLevel++;
            DrawSrcMode(materialEditor);
            DrawDstMode(materialEditor);
            DrawCullMode(materialEditor);
            DrawZTestMode(materialEditor);
            materialEditor.ShaderProperty(softParticle, "软粒子强度");
            
            EditorGUI.indentLevel++;
            DrawEnableReverseSoftParticleToggle(materialEditor);
            DrawEnableEnableMixfresnelToggle(materialEditor);
            EditorGUI.indentLevel--;

            materialEditor.ShaderProperty(alphaMulti, "透明度倍增强度");
            //3.真正的shader中的参数部分
            DrawEnableCustomdataToggle(materialEditor);
            //DrawCustomOptionMode(materialEditor);
            EditorGUI.indentLevel--;
        }

        #endregion
        EditorGUILayout.Space(10);

        #region 主贴图参数属性折叠
        // 折叠标题
        showMainTexSettings = EditorGUILayout.Foldout(showMainTexSettings, "主贴图", true);
        if (showMainTexSettings)
        {
            // 缩进，让层级更清晰
            EditorGUI.indentLevel++;
            #region 基础属性绘制的部分
            // 贴图（Texture）
            DrawMaintexUVMode(materialEditor);
            materialEditor.TexturePropertySingleLine(new GUIContent("主贴图"), mainTex);
            materialEditor.ColorProperty(mainTexColor, "主贴图颜色");
            EditorGUILayout.Space(5);
            materialEditor.ShaderProperty(mainTexTO, "主贴图UV");
            EditorGUILayout.Space(5);
            materialEditor.ShaderProperty(mainTexSpeedX, "主贴图X流动");
            materialEditor.ShaderProperty(mainTexSpeedY, "主贴图Y流动");
            materialEditor.ShaderProperty(noiseToMain, "扭曲对主贴图强度");


            DrawenableenableCausticsOnToggle(materialEditor);

            #endregion

            EditorGUI.indentLevel--;
        }
        #endregion
        
        EditorGUILayout.Space(10);
        #region 扭曲贴图属性折叠
        // 折叠标题
        showNoiseTexSettings = EditorGUILayout.Foldout(showNoiseTexSettings, "扭曲贴图", true);
        if (showNoiseTexSettings)
        {
            DraweEnableNoiseStrToggle(materialEditor);

            // 缩进，让层级更清晰
            EditorGUI.indentLevel++;
            #region 基础属性绘制的部分
            DrawNoisetexUVMode(materialEditor);
            materialEditor.TexturePropertySingleLine(new GUIContent("扭曲贴图"), noiseTex);
            materialEditor.ShaderProperty(noiseStr, "扭曲强度");
            materialEditor.ShaderProperty(noiseTexTO, "扭曲贴图UV");
            materialEditor.ShaderProperty(noiseSpeedX, "扭曲贴图X流动");
            materialEditor.ShaderProperty(noiseSpeedY, "扭曲贴图Y流动");


            #endregion

            EditorGUI.indentLevel--;
        }
        #endregion
        #region 叠加贴图属性折叠
        // 折叠标题
        showAddTexSettings = EditorGUILayout.Foldout(showAddTexSettings, "叠加贴图", true);
        if (showAddTexSettings)
        {
            DraweEnableAddTexStrToggle(materialEditor);

            // 缩进，让层级更清晰
            EditorGUI.indentLevel++;
            #region 基础属性绘制的部分
            DrawAddtexUVMode(materialEditor);
            materialEditor.TexturePropertySingleLine(new GUIContent("叠加贴图"), addTex);
            DrawEnableAddChannelAToggle(materialEditor);
            materialEditor.ColorProperty(addTexColor, "叠加贴图颜色");
            materialEditor.ShaderProperty(noiseToAdd, "扭曲对叠加贴图强度");
            materialEditor.ShaderProperty(addTexTO, "叠加贴图UV");
            materialEditor.ShaderProperty(addSpeedX, "叠加贴图X流动");
            materialEditor.ShaderProperty(addSpeedY, "叠加贴图Y流动");


            #endregion

            EditorGUI.indentLevel--;
        }
        #endregion

        #region 相乘贴图属性折叠
        // 折叠标题
        showMultiTexSettings = EditorGUILayout.Foldout(showMultiTexSettings, "相乘贴图", true);
        if (showMultiTexSettings)
        {
            DraweEnableMaskTexStrToggle(materialEditor);

            // 缩进，让层级更清晰
            EditorGUI.indentLevel++;
            #region 基础属性绘制的部分
            DrawMultitexUVMode(materialEditor);
            materialEditor.TexturePropertySingleLine(new GUIContent("相乘贴图"), multiTex);
            DrawEnableMultiGrayToAlpha(materialEditor);
            materialEditor.ColorProperty(multiTexColor, "相乘贴图颜色");
            materialEditor.ShaderProperty(noiseToMulti, "扭曲对相乘贴图强度");
            materialEditor.ShaderProperty(multiStr, "相乘图强度");
            materialEditor.ShaderProperty(multiTexTO, "相乘图UV");
            materialEditor.ShaderProperty(multiSpeedX, "相乘贴图X流动");
            materialEditor.ShaderProperty(multiSpeedY, "相乘贴图Y流动");


            #endregion

            EditorGUI.indentLevel--;
        }
        #endregion
        #region 溶解贴图属性折叠
        // 折叠标题
        showDisTexSettings = EditorGUILayout.Foldout(showDisTexSettings, "溶解贴图", true);
        if (showDisTexSettings)
        {
            DraweEnableDissolveToggle(materialEditor);

            // 缩进，让层级更清晰
            EditorGUI.indentLevel++;
            #region 基础属性绘制的部分
            DrawDistexUVMode(materialEditor);
            materialEditor.TexturePropertySingleLine(new GUIContent("溶解贴图"), disTex);
            materialEditor.ShaderProperty(noiseToDis, "扭曲对溶解贴图强度");
            materialEditor.ShaderProperty(disAmount, "溶解进程");
            materialEditor.ShaderProperty(disHard, "溶解硬度");
            materialEditor.ShaderProperty(disTexTO, "溶解图UV");
            materialEditor.ShaderProperty(disSpeedX, "溶解图X流动");
            materialEditor.ShaderProperty(disSpeedY, "溶解图Y流动");
            materialEditor.ColorProperty(disEdgeColor, "溶解边缘颜色");
            materialEditor.ShaderProperty(disEdgeSoft, "溶解边缘范围");



            #endregion

            EditorGUI.indentLevel--;
        }
        #endregion
        #region Fresnel属性折叠
        // 折叠标题
        showFresnelSettings = EditorGUILayout.Foldout(showFresnelSettings, "菲涅尔设置", true);
        if (showFresnelSettings)
        {
            // 缩进，让层级更清晰
            EditorGUI.indentLevel++;
            #region 基础属性绘制的部分
            DrawEnableAngleFadeToggle(materialEditor);
            DrawEnableReversalToggle(materialEditor);
            materialEditor.ColorProperty(fresnelColor, "菲涅尔颜色");


            #endregion

            EditorGUI.indentLevel--;
        }
        #endregion
        #region 顶点偏移属性折叠
        // 折叠标题
        showVOSettings = EditorGUILayout.Foldout(showVOSettings, "顶点偏移", true);
        if (showVOSettings)
        {
            DrawEnableVOToggle(materialEditor);

            // 缩进，让层级更清晰
            EditorGUI.indentLevel++;
            #region 基础属性绘制的部分
            DrawEnableNormalVOToggle(materialEditor);
            materialEditor.ShaderProperty(VOStr, "顶点偏移强度");
            DrawenablesingleStrToggle(materialEditor);
            materialEditor.TexturePropertySingleLine(new GUIContent("顶点偏移贴图"), voNoise);
            DrawVOUV2Toggle(materialEditor);
            materialEditor.ShaderProperty(voTO, "顶点贴图UV");
            materialEditor.ShaderProperty(voNoiseSpeedX, "顶点贴图X流动");
            materialEditor.ShaderProperty(voNoiseSpeedY, "顶点贴图Y流动");
            DrawVOCustomMode1(materialEditor);
            DrawVOCustomTO(materialEditor);

            materialEditor.TexturePropertySingleLine(new GUIContent("顶点贴图遮罩"), voMask);
            DrawenableVOMaskUV2Toggle(materialEditor);
            DrawenablereverseVOMaskUV2Toggle(materialEditor);
            materialEditor.ShaderProperty(voMaskTO, "顶点贴图遮罩UV");
            materialEditor.ShaderProperty(voMaskSpeedX, "顶点贴图遮罩X流动");
            materialEditor.ShaderProperty(voMaskSpeedY, "顶点贴图遮罩Y流动");



            #endregion

            EditorGUI.indentLevel--;
        }
        #endregion
    }

    //下面是使用枚举必须的转换方法
    private void DrawSrcMode(MaterialEditor materialEditor)
    {
        // 当前枚举值（从 float 转 enum）
        SrcMode mode = (SrcMode)srcMode.floatValue;

        EditorGUI.BeginChangeCheck();

        mode = (SrcMode)EditorGUILayout.EnumPopup("SrcMode",mode);


        if (EditorGUI.EndChangeCheck())//与材质属性通信
        {
            materialEditor.RegisterPropertyChangeUndo("Src Mode Change");
            srcMode.floatValue = (float)mode;

            
        }


    }

    private void DrawDstMode(MaterialEditor materialEditor)
    {
        // 当前枚举值（从 float 转 enum）
        DstMode mode = (DstMode)dstMode.floatValue;

        EditorGUI.BeginChangeCheck();

        mode = (DstMode)EditorGUILayout.EnumPopup("DstMode", mode);


        if (EditorGUI.EndChangeCheck())//与材质属性通信
        {
            materialEditor.RegisterPropertyChangeUndo("Dst Mode Change");
            // Undo 让编辑器知道这是一次“合法的修改”
            //告诉 Unity：接下来我要修改材质属性，请把这次修改记录到 Undo 系统里，并用这个字符串作为 Undo 的描述。
            dstMode.floatValue = (float)mode;


        }


    }

    private void DrawCullMode(MaterialEditor materialEditor)
    {
        // 当前枚举值（从 float 转 enum）
        CullMode mode = (CullMode)cullMode.floatValue;

        EditorGUI.BeginChangeCheck();

        mode = (CullMode)EditorGUILayout.EnumPopup("CullMode", mode);


        if (EditorGUI.EndChangeCheck())//与材质属性通信
        {
            materialEditor.RegisterPropertyChangeUndo("Cull Mode Change");
            // Undo 让编辑器知道这是一次“合法的修改”
            //告诉 Unity：接下来我要修改材质属性，请把这次修改记录到 Undo 系统里，并用这个字符串作为 Undo 的描述。
            cullMode.floatValue = (float)mode;


        }


    }
    private void DrawZTestMode(MaterialEditor materialEditor)
    {
        // 当前枚举值（从 float 转 enum）
        ZTestMode mode = (ZTestMode)zTestMode.floatValue;

        EditorGUI.BeginChangeCheck();

        mode = (ZTestMode)EditorGUILayout.EnumPopup("ZTestMode", mode);


        if (EditorGUI.EndChangeCheck())//与材质属性通信
        {
            materialEditor.RegisterPropertyChangeUndo("Z Mode Change");
            // Undo 让编辑器知道这是一次“合法的修改”
            //告诉 Unity：接下来我要修改材质属性，请把这次修改记录到 Undo 系统里，并用这个字符串作为 Undo 的描述。
            zTestMode.floatValue = (float)mode;


        }
    }
    private void DrawCustomOptionMode(MaterialEditor materialEditor)
    {
        // 当前枚举值（从 float 转 enum）
        CustomOption mode = (CustomOption)customOption.floatValue;

        EditorGUI.BeginChangeCheck();

        mode = (CustomOption)EditorGUILayout.EnumPopup("CustomOption", mode);


        if (EditorGUI.EndChangeCheck())//与材质属性通信
        {
            materialEditor.RegisterPropertyChangeUndo("CustomOption Mode Change");
            // Undo 让编辑器知道这是一次“合法的修改”
            //告诉 Unity：接下来我要修改材质属性，请把这次修改记录到 Undo 系统里，并用这个字符串作为 Undo 的描述。
            customOption.floatValue = (float)mode;


        }


    }

    private void DrawMaintexUVMode(MaterialEditor materialEditor)
    {
        // 当前枚举值（从 float 转 enum）
        MaintexUVMode mode = (MaintexUVMode)mainTexUVMode.floatValue;

        EditorGUI.BeginChangeCheck();

        mode = (MaintexUVMode)EditorGUILayout.EnumPopup("主贴图UV模式", mode);


        if (EditorGUI.EndChangeCheck())//与材质属性通信
        {
            materialEditor.RegisterPropertyChangeUndo("MaintexUVMode Change");
            // Undo 让编辑器知道这是一次“合法的修改”
            //告诉 Unity：接下来我要修改材质属性，请把这次修改记录到 Undo 系统里，并用这个字符串作为 Undo 的描述。
            mainTexUVMode.floatValue = (float)mode;


        }
    }
    private void DrawNoisetexUVMode(MaterialEditor materialEditor)
    {
        // 当前枚举值（从 float 转 enum）
        NoisetexUVMode mode = (NoisetexUVMode)noiseTexUVMode.floatValue;

        EditorGUI.BeginChangeCheck();

        mode = (NoisetexUVMode)EditorGUILayout.EnumPopup("扭曲贴图UV模式", mode);


        if (EditorGUI.EndChangeCheck())//与材质属性通信
        {
            materialEditor.RegisterPropertyChangeUndo("NoisetexUVMode Change");
            // Undo 让编辑器知道这是一次“合法的修改”
            //告诉 Unity：接下来我要修改材质属性，请把这次修改记录到 Undo 系统里，并用这个字符串作为 Undo 的描述。
            noiseTexUVMode.floatValue = (float)mode;


        }
    }
    private void DrawAddtexUVMode(MaterialEditor materialEditor)
    {
        // 当前枚举值（从 float 转 enum）
        AddTexUVMode mode = (AddTexUVMode)addTexUVMode.floatValue;

        EditorGUI.BeginChangeCheck();

        mode = (AddTexUVMode)EditorGUILayout.EnumPopup("叠加贴图UV模式", mode);


        if (EditorGUI.EndChangeCheck())//与材质属性通信
        {
            materialEditor.RegisterPropertyChangeUndo("AddTexUVMode Change");
            // Undo 让编辑器知道这是一次“合法的修改”
            //告诉 Unity：接下来我要修改材质属性，请把这次修改记录到 Undo 系统里，并用这个字符串作为 Undo 的描述。
            addTexUVMode.floatValue = (float)mode;


        }
    }
    private void DrawMultitexUVMode(MaterialEditor materialEditor)
    {
        // 当前枚举值（从 float 转 enum）
        MultiTexUVMode mode = (MultiTexUVMode)multiTexUVMode.floatValue;

        EditorGUI.BeginChangeCheck();

        mode = (MultiTexUVMode)EditorGUILayout.EnumPopup("相乘贴图UV模式", mode);


        if (EditorGUI.EndChangeCheck())//与材质属性通信
        {
            materialEditor.RegisterPropertyChangeUndo("MultiUVMode Change");
            // Undo 让编辑器知道这是一次“合法的修改”
            //告诉 Unity：接下来我要修改材质属性，请把这次修改记录到 Undo 系统里，并用这个字符串作为 Undo 的描述。
            multiTexUVMode.floatValue = (float)mode;


        }
    }
    private void DrawDistexUVMode(MaterialEditor materialEditor)
    {
        // 当前枚举值（从 float 转 enum）
        DisUVMode mode = (DisUVMode)disUVMode.floatValue;

        EditorGUI.BeginChangeCheck();

        mode = (DisUVMode)EditorGUILayout.EnumPopup("溶解贴图UV模式", mode);


        if (EditorGUI.EndChangeCheck())//与材质属性通信
        {
            materialEditor.RegisterPropertyChangeUndo("DisUVMode Change");
            // Undo 让编辑器知道这是一次“合法的修改”
            //告诉 Unity：接下来我要修改材质属性，请把这次修改记录到 Undo 系统里，并用这个字符串作为 Undo 的描述。
            disUVMode.floatValue = (float)mode;


        }
    }

    private void DrawVOVectorMode(MaterialEditor materialEditor)
    {
        // 当前枚举值（从 float 转 enum）
        VOVectorMask mode = (VOVectorMask)voVectorMask.floatValue;

        EditorGUI.BeginChangeCheck();

        mode = (VOVectorMask)EditorGUILayout.EnumPopup("强度遮罩", mode);


        if (EditorGUI.EndChangeCheck())//与材质属性通信
        {
            materialEditor.RegisterPropertyChangeUndo("VOVectorMask Change");
            // Undo 让编辑器知道这是一次“合法的修改”
            //告诉 Unity：接下来我要修改材质属性，请把这次修改记录到 Undo 系统里，并用这个字符串作为 Undo 的描述。
            voVectorMask.floatValue = (float)mode;


        }
    }
    private void DrawVOCustomMode1(MaterialEditor materialEditor)
    {
        // 当前枚举值（从 float 转 enum）
        VoCustomStr mode = (VoCustomStr)voCustomStr.floatValue;

        EditorGUI.BeginChangeCheck();

        mode = (VoCustomStr)EditorGUILayout.EnumPopup("自定义顶点偏移强度", mode);


        if (EditorGUI.EndChangeCheck())//与材质属性通信
        {
            materialEditor.RegisterPropertyChangeUndo("VoCustomStr Change");
            // Undo 让编辑器知道这是一次“合法的修改”
            //告诉 Unity：接下来我要修改材质属性，请把这次修改记录到 Undo 系统里，并用这个字符串作为 Undo 的描述。
            voCustomStr.floatValue = (float)mode;


        }
    }
    private void DrawVOCustomTO(MaterialEditor materialEditor)
    {
        // 当前枚举值（从 float 转 enum）
        VOCustomTO mode = (VOCustomTO)voCustomTO.floatValue;

        EditorGUI.BeginChangeCheck();

        mode = (VOCustomTO)EditorGUILayout.EnumPopup("自定义顶点偏移", mode);


        if (EditorGUI.EndChangeCheck())//与材质属性通信
        {
            materialEditor.RegisterPropertyChangeUndo("VoCustomTO Change");
            // Undo 让编辑器知道这是一次“合法的修改”
            //告诉 Unity：接下来我要修改材质属性，请把这次修改记录到 Undo 系统里，并用这个字符串作为 Undo 的描述。
            voCustomTO.floatValue = (float)mode;


        }
    }

    //下面是使用toggle的必须的转换方法(带控制参数显隐)
    private void DrawEnableCustomdataToggle(MaterialEditor materialEditor)
    {
        // float → bool
        bool enabled = enableCustomdata.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle( "使用Customdata",enabled );

        if (EditorGUI.EndChangeCheck())
        {

            // bool → float
            enableCustomdata.floatValue = enabled ? 1f : 0f;

           
        }
        if (enabled)
        {
            EditorGUI.indentLevel++;

            materialEditor.ShaderProperty(customOption, "使用模式");

            EditorGUI.indentLevel--;
        }
    }

    //下面是使用toggle的必须的转换方法（单纯开关）
    private void DrawEnableAddChannelAToggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = enableAddChannelA.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("使用A通道", enabled);

        if (EditorGUI.EndChangeCheck())
        {
            materialEditor.RegisterPropertyChangeUndo("Toggle EnableA");

            // bool → float
            enableAddChannelA.floatValue = enabled ? 1f : 0f;

        }
    }

    //下面是使用toggle的必须的转换方法（单纯开关）
    private void DrawEnableMultiGrayToAlpha(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = grayToAlpha.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("使用A通道", enabled);

        if (EditorGUI.EndChangeCheck())
        {
            materialEditor.RegisterPropertyChangeUndo("Toggle GtoA");

            // bool → float
            grayToAlpha.floatValue = enabled ? 1f : 0f;

            // 同步 Shader Keyword,ASE中使用switch才可以用Keyword，但此处采用enable，故这段代码无用
            /*
            foreach (Material mat in materialEditor.targets)
            {
                if (enabled)
                    mat.EnableKeyword("_USENORMAL_GtoA");
                else
                    mat.DisableKeyword("_USENORMAL_GtoA");
            }
            */
        }
    }
    //下面是使用toggle的必须的转换方法（单纯开关,是否反转软粒子）
    private void DrawEnableReverseSoftParticleToggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = reverseSoftParticle.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("反转软粒子（接触边缘着色）", enabled);

        if (EditorGUI.EndChangeCheck())
        {
            materialEditor.RegisterPropertyChangeUndo("Toggle reverseSoftParticle");

            // bool → float
            reverseSoftParticle.floatValue = enabled ? 1f : 0f;

        }
    }
    //下面是使用toggle的必须的转换方法（单纯开关,是否混合菲涅尔）
    private void DrawEnableEnableMixfresnelToggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = enableMixfresnel.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("混合菲涅尔(需要同步开启菲涅尔)", enabled);

        if (EditorGUI.EndChangeCheck())
        {
            materialEditor.RegisterPropertyChangeUndo("Toggle enableMixfresnel");

            // bool → float
            enableMixfresnel.floatValue = enabled ? 1f : 0f;

        }
    }

    //下面是使用toggle的必须的转换方法（带显示调整斜视角的判断）
    private void DrawEnableAngleFadeToggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = enableEdgeFade.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("开启斜视角消隐", enabled);

        if (EditorGUI.EndChangeCheck())
        {
            materialEditor.RegisterPropertyChangeUndo("Toggle EnableAngleFade");

            // bool → float
            enableEdgeFade.floatValue = enabled ? 1f : 0f;
            

        }
        if (enabled)
        {
            EditorGUI.indentLevel++;

            materialEditor.ShaderProperty(angleFadePower, "消隐强度");
            materialEditor.ShaderProperty(angleFadeStr, "消隐范围");

            EditorGUI.indentLevel--;
        }
    }

    private void DrawEnableReversalToggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = enablereversalFade.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("反转斜视角消隐（菲涅尔）", enabled);

        if (EditorGUI.EndChangeCheck())
        {
            materialEditor.RegisterPropertyChangeUndo("Toggle enablereversalFadee");

            // bool → float
            enablereversalFade.floatValue = enabled ? 1f : 0f;

        }
    }

    private void DrawEnableVOToggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = enableVO.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("开启顶点动画", enabled);

        if (EditorGUI.EndChangeCheck())
        {
            materialEditor.RegisterPropertyChangeUndo("Toggle VO");

            // bool → float
            enableVO.floatValue = enabled ? 1f : 0f;

        }
        if (enabled)
        {
            EditorGUI.indentLevel++;
            DrawVOVectorMode(materialEditor);
            EditorGUI.indentLevel--;
        }
    }
    private void DrawEnableNormalVOToggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = enableNormalVO.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("以法线方向偏移", enabled);

        if (EditorGUI.EndChangeCheck())
        {
            materialEditor.RegisterPropertyChangeUndo("Toggle NormalVO");

            // bool → float
            enableNormalVO.floatValue = enabled ? 1f : 0f;

        }
        if (enabled)
        {
            EditorGUI.indentLevel++;
            materialEditor.ShaderProperty(normalVOStr, "法线方向权重");
            EditorGUI.indentLevel--;
        }
       
    }

    private void DrawVOUV2Toggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = enableNoiseUV2.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("使用模型UV2", enabled);

        if (EditorGUI.EndChangeCheck())
        {
            materialEditor.RegisterPropertyChangeUndo("Toggle enableNoiseUV2");

            // bool → float
            enableNoiseUV2.floatValue = enabled ? 1f : 0f;

        }
       
    }

    private void DrawenableVOMaskUV2Toggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = enableVOMaskUV2.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("遮罩图使用模型UV2", enabled);

        if (EditorGUI.EndChangeCheck())
        {
            materialEditor.RegisterPropertyChangeUndo("Toggle enableVOMaskUV2");

            // bool → float
            enableVOMaskUV2.floatValue = enabled ? 1f : 0f;

        }

    }
    private void DrawenablereverseVOMaskUV2Toggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = reverseVOMaskUV2.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("反转遮罩图", enabled);

        if (EditorGUI.EndChangeCheck())
        {
            materialEditor.RegisterPropertyChangeUndo("Toggle reverseVOMaskUV2");

            // bool → float
            reverseVOMaskUV2.floatValue = enabled ? 1f : 0f;

        }

    }
    private void DrawenablesingleStrToggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = singleStr.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("单向强度", enabled);

        if (EditorGUI.EndChangeCheck())
        {
            materialEditor.RegisterPropertyChangeUndo("Toggle singleStr");

            // bool → float
            singleStr.floatValue = enabled ? 1f : 0f;

        }

    }
    private void DrawenableenableCausticsOnToggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = enableCausticsOn.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("开启色相差", enabled);

        if (EditorGUI.EndChangeCheck())
        {
            materialEditor.RegisterPropertyChangeUndo("Toggle enableCausticsOn");

            // bool → float
            enableCausticsOn.floatValue = enabled ? 1f : 0f;

        }
        if (enabled)
        {
            EditorGUI.indentLevel++;
            materialEditor.ShaderProperty(colorStrength, "色彩影响强度");
            materialEditor.ColorProperty(causticsColor1, "颜色1");
            materialEditor.ShaderProperty(causticsColor1Move, "颜色1偏移");
            materialEditor.ShaderProperty(noiseToCaustics, "扭曲贴图对色彩1偏移影响值");
            materialEditor.ColorProperty(causticsColor2, "颜色2");
            materialEditor.ShaderProperty(causticsColor2Move, "颜色2偏移");
            materialEditor.ShaderProperty(noiseToCaustics2, "扭曲贴图对色彩2偏移影响值");
            materialEditor.ColorProperty(causticsColor3, "颜色3");
            materialEditor.ShaderProperty(causticsColor3Move, "颜色3偏移");
            materialEditor.ShaderProperty(noiseToCaustics3, "扭曲贴图对色彩3偏移影响值");


            EditorGUI.indentLevel--;
        }

    }

    private void DraweEnableNoiseStrToggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = enableNoise.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("开启扭曲贴图", enabled);

        if (EditorGUI.EndChangeCheck())
        {

            // bool → float
            enableNoise.floatValue = enabled ? 1f : 0f;

        }

    }
    private void DraweEnableAddTexStrToggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = enableAddTex.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("开启叠加贴图", enabled);

        if (EditorGUI.EndChangeCheck())
        {

            // bool → float
            enableAddTex.floatValue = enabled ? 1f : 0f;

        }

    }
    private void DraweEnableMaskTexStrToggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = enableMaskTex.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("开启相乘贴图", enabled);

        if (EditorGUI.EndChangeCheck())
        {

            // bool → float
            enableMaskTex.floatValue = enabled ? 1f : 0f;

        }

    }
    private void DraweEnableDissolveToggle(MaterialEditor materialEditor)
    {

        // float → bool
        bool enabled = enableDissolve.floatValue > 0.5f;

        EditorGUI.BeginChangeCheck();

        enabled = EditorGUILayout.Toggle("开启溶解贴图", enabled);

        if (EditorGUI.EndChangeCheck())
        {

            // bool → float
            enableDissolve.floatValue = enabled ? 1f : 0f;

        }

    }
}
