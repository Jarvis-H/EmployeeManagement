package util;

public class Pagination {
	private int curPage;
	private int pageNum;
	private int start;
	private int end;
	private int begin;

	public Pagination(int curPage, int count, int numInPage, int numOfPage) {
		this.curPage = curPage;
		if (this.curPage <= 1) {
			this.curPage = 1;
		}

		if (count % numInPage == 0) {
			pageNum = count / numInPage;
		} else {
			pageNum = count / numInPage + 1;
		}

		if (this.curPage >= pageNum) {
			this.curPage = pageNum;
		}

		start = this.curPage - numOfPage / 2;
		if (start <= 1) {
			start = 1;
		}
		end = start + numOfPage - 1;
		if (end >= pageNum) {
			end = pageNum;
			start = end - numOfPage + 1;
		}
		if (start <= 1) {
			start = 1;
		}

		begin = numInPage * (this.curPage - 1);
	}

	public int getBegin() {
		return begin;
	}

	public int getCurPage() {
		return curPage;
	}

	public int getPageNum() {
		return pageNum;
	}

	public int getStart() {
		return start;
	}

	public int getEnd() {
		return end;
	}

}
