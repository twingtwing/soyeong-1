package co.kids.prj.review.service;

import java.util.List;

public interface ReviewMapper {
	List<ReviewVO> reviewSelectList(int rno);
	int reviewInsert(ReviewVO vo);
	ReviewVO reviewCheckDup(ReviewVO vo);
}
