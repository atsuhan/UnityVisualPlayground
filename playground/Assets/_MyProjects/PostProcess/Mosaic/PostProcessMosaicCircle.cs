using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[System.Serializable]
[PostProcess(typeof(PostProcessMosaicRenderer), PostProcessEvent.AfterStack, "atsuhan/PostProcess/Mosaic")]
public class PostProcessMosaic : PostProcessEffectSettings
{
  public FloatParameter tillingX = new FloatParameter { value = 1.0f };
  public FloatParameter tillingY = new FloatParameter { value = 1.0f };
}

public sealed class PostProcessMosaicRenderer : PostProcessEffectRenderer<PostProcessMosaic>
{
  public override void Render(PostProcessRenderContext context)
  {
    var sheet = context.propertySheets.Get(Shader.Find("atsuhan/PostProcess/Mosaic"));
    sheet.properties.SetFloat("_TillingX", settings.tillingX);
    sheet.properties.SetFloat("_TillingY", settings.tillingY);
    context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
  }
}