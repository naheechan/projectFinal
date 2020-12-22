package com.kh.maison.with.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.member.model.vo.Member;
import com.kh.maison.with.model.vo.WithAsk;
import com.kh.maison.with.model.vo.WithBoard;
import com.kh.maison.with.model.vo.WithComment;
import com.kh.maison.with.model.vo.WithReport;

public interface WithBoardDao {
	
	int insertWith(SqlSessionTemplate session, WithBoard wb);
	
	List<WithBoard> selectAllWith(SqlSessionTemplate session, int cPage, int numPerPage);
	
	int selectWithCount(SqlSessionTemplate session);
	
	WithBoard selectOneWith(SqlSessionTemplate session,int no);
	
	int insertWithReply(SqlSessionTemplate session,WithComment comment);
	
	List<WithComment> selectAllWithReply(SqlSessionTemplate session, int bno);
	
	int insertWithReplySecond(SqlSessionTemplate session,WithComment comment);

	int deleteWithReply(SqlSessionTemplate session,int no);
	
	WithComment selectOneWithReply(SqlSessionTemplate session,int wcNo);
	
	int withBoardCount(SqlSessionTemplate session,int no);

	int updateWithReply(SqlSessionTemplate session,WithComment wc);
	
	int withStatusUpdate(SqlSessionTemplate session,WithBoard wb);
	
	int removeWith(SqlSessionTemplate session,int wbNo);
	
	int insertWithReport(SqlSessionTemplate session,WithReport wr);
	
	int updateWith(SqlSessionTemplate session, WithBoard wb);

	int inserWithAsk(SqlSessionTemplate session,WithAsk wa);
	
	Member selectEmailAndPhone(SqlSessionTemplate session,int no);
	
	//여기부터 마이페이지에 함께해요 관련
	List<WithBoard> bringAllWithBoard(SqlSessionTemplate session,String memberId,int cPage,int numPerPage);

	int bringAllWithBoardCount(SqlSessionTemplate session,String memberId);
	
	int deleteBringAllWith(SqlSessionTemplate session,int checkfordelete);

	List<WithComment> bringAllWithComment(SqlSessionTemplate session,String memberId,int cPage,int numPerPage);

	int bringAllWithCommentCount(SqlSessionTemplate session,String memberId);
	
	List<WithBoard> bringCommentedWith(SqlSessionTemplate session,String memberId,int cPage,int numPerPage);
	
	int bringCommentedWithCount(SqlSessionTemplate session,String memberId);
	
	int deleteBringAllWithComment(SqlSessionTemplate session,int checkStatus);
}
