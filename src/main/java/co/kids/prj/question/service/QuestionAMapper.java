package co.kids.prj.question.service;

import java.util.List;

public interface QuestionAMapper {
	List<QuestionAVO> questionAList();
	QuestionAVO questionASelect(QuestionAVO vo);
	int questionAInsert(QuestionAVO vo);
	int questionAUpdate(QuestionAVO vo);
	int questionADelete(QuestionAVO vo);
}
