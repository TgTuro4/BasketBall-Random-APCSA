class Setting {
  private String bgrImg;

  public Setting(String img) {
    bgrImg = img;
  }

  public void applySetting(String newImg) {
    bgrImg = newImg;
  }

  public void draw() {
    background(loadImage(bgrImg));
  }
}
