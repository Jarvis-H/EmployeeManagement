package util;

public enum Grade {

	a("优秀"), b("良好"), c("一般"), d("及格"), e("不及格"),f(null);

	private String value;

	private Grade(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}

	public static Grade getGrade(String value) {
		Grade g = Grade.f;
		if (value != null) {
			switch (value) {
			case "优秀":
				g = Grade.a;
				break;
			case "良好":
				g = Grade.b;
				break;
			case "一般":
				g = Grade.c;
				break;
			case "及格":
				g = Grade.d;
				break;
			case "不及格":
				g = Grade.e;
				break;
			default:
				break;
			}

		}
		return g;
	}
}
