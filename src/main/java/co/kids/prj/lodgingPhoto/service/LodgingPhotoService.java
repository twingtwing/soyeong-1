package co.kids.prj.lodgingPhoto.service;

import java.util.List;

import co.kids.prj.reservation.service.ReservLodVO;

public interface LodgingPhotoService {
	List<LodgingPhotoVO> selectListPhoto();
	LodgingPhotoVO selectPhoto(LodgingPhotoVO vo);
	int insertPhoto(LodgingPhotoVO vo);
	int updatePhoto(LodgingPhotoVO vo);
	int deletePhoto(LodgingPhotoVO vo);

}
