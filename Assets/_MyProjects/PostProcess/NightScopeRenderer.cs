using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public sealed class NightScopeRenderer : PostProcessEffectRenderer<NightScopeSetting>
{
  public override void Render(PostProcessRenderContext context)
  {
    var sheet = context.propertySheets.Get(Shader.Find("atsuhan/PostProcess/NightScope"));
    sheet.properties.SetTexture("_PaletteTex", settings.PaletteTexture);
    sheet.properties.SetFloat("_PaletteWidth", settings.paletteWidth);
    context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
  }
}