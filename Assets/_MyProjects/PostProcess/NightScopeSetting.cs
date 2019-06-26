using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[System.Serializable]
[PostProcess(typeof(NightScopeRenderer), PostProcessEvent.AfterStack, "atsuhan/PostProcess/NightScope")]
public sealed class NightScopeSetting : PostProcessEffectSettings
{
  public ColorParameter color1 = new ColorParameter { value = Color.gray };
  public ColorParameter color2 = new ColorParameter { value = Color.gray };
  public ColorParameter color3 = new ColorParameter { value = Color.gray };
  public ColorParameter color4 = new ColorParameter { value = Color.gray };

  private Texture2D _paletteTexture;
  public Texture2D PaletteTexture
  {
    get
    {
      Color[] color = new Color[] { color1, color2, color3, color4 };
      if (_paletteTexture == null)
      {
        _paletteTexture = new Texture2D(color.Length, 1, TextureFormat.ARGB32, false);
        _paletteTexture.filterMode = FilterMode.Point;
      }
      _paletteTexture.SetPixels(color);
      _paletteTexture.Apply();
      return _paletteTexture;
    }
  }
  public FloatParameter paletteWidth = new FloatParameter { };
}