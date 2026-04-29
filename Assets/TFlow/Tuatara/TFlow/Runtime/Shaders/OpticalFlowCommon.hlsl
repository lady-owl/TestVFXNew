//UNITY_SHADER_NO_UPGRADE
#ifndef OPTICAL_FLOW_COMMON
#define OPTICAL_FLOW_COMMON

// Decode a float from 2 channels
float DecodeFloatFromDual(in float2 enc)
{
	float2 kDecodeDot = float2(1.0, 1 / 255.0);
	return dot(enc, kDecodeDot);
}

// Computes subframe UVs
void FrameUV_float(in float2 uv, in float2 size, in float frame, out float2 frameUV)
{
	frameUV = float2(0, 0);

	float2 invSize = 1.0 / size;
	float2 offset = float2(fmod(frame, size.x), size.y - 1.0 - floor(frame * invSize.x));
	frameUV = (offset + uv) * invSize;
}

// Computes flipbook current and next frame UVs
void OpticalFlowUVAnimation_float(in float2 uv, in float columns, in float rows, in float time, out float2 currentFrameUV, out float2 nextFrameUV, out float blendFactor)
{
	currentFrameUV = float2(0, 0);
	nextFrameUV = float2(0, 0);
	blendFactor = 0;

	float2 size = float2(columns, rows);
	float blend = frac(time);
	float frame = time - blend;
	FrameUV_float(uv, size, frame, currentFrameUV);
	FrameUV_float(uv, size, frame + 1, nextFrameUV);
	blendFactor = blend;
}

// Computes flipbook current and next frame UVs using motion vectors
void OpticalFlowComputeMotionUV_float(	in float2 currentFrameUV, in float2 nextFrameUV,
										in float4 currentMotionVectors, in float2 nextMotionVectors, in float isEncoded, in float intensity,
										in float columns, in float rows, in float blendFactor,
										out float2 currentFrameMotionUV, out float2 nextFrameMotionUV)
{
	currentFrameMotionUV = float2(0.0, 0.0);
	nextFrameMotionUV = float2(0.0, 0.0);

	// Get intensity from property or decoded motion vectors map blue and alpha channels
	float bakedIntensity = DecodeFloatFromDual(currentMotionVectors.ba);
	intensity = lerp(intensity, bakedIntensity, isEncoded);
	float2 strength = float2(intensity, intensity) * (float2(1.0, 1.0) / float2(columns, rows));
	// Remap
	currentFrameMotionUV = currentMotionVectors.rg * 2.0 - 1.0;
	nextFrameMotionUV = nextMotionVectors.rg * 2.0 - 1.0;
	// Apply intensity
	currentFrameMotionUV = currentFrameMotionUV * (-strength * blendFactor);
	nextFrameMotionUV = nextFrameMotionUV * (strength * (1.0 - blendFactor));
	// Apply on provided UVs
	currentFrameMotionUV += currentFrameUV;
	nextFrameMotionUV += nextFrameUV;
}

#endif // OPTICAL_FLOW_COMMON