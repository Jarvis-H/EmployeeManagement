package bean;

import java.awt.image.BufferedImage;

public class ValidateCode {

	private BufferedImage image;
	private String rand;
	public BufferedImage getImage() {
		return image;
	}
	public void setImage(BufferedImage image) {
		this.image = image;
	}
	public String getRand() {
		return rand;
	}
	public void setRand(String rand) {
		this.rand = rand;
	}
	
}
