package org.avManager.view
{
	import flash.display.DisplayObject;
	
	import org.avManager.model.data.ActressData;
	import org.avManager.model.data.VideoData;
	import org.avManager.view.about.About;
	import org.avManager.view.actress.ActressDetailFrame;
	import org.avManager.view.loading.Loading;
	import org.avManager.view.video.VideoDetailFrame;
	import org.libra.flex.utils.PopUpUtil;

	public final class UIManager
	{
		private static var _instance:UIManager;
		
		private var _uiRoot:DisplayObject;
		
		private var _about:About;
		
		private var _videoDetailFrame:VideoDetailFrame
		
		private var _actressDetailFrame:ActressDetailFrame;
		
		private var _loading:Loading;
		
		public function UIManager(t:T)
		{
			
		}
		
		public function init(uiRoot:DisplayObject):void{
			this._uiRoot = uiRoot;
		}
		
		public function showAbout():void{
			if(!_about) _about = new About();
			PopUpUtil.instance.addPopUp(this._about, this._uiRoot, true, 1);
		}
		
		public function showVideoDetailFrame(videoID:String, videoData:VideoData):void{
			if(!_videoDetailFrame) _videoDetailFrame = new VideoDetailFrame();
			PopUpUtil.instance.addPopUp(this._videoDetailFrame, this._uiRoot, true, 1);
			_videoDetailFrame.videoDataID = videoID;
			_videoDetailFrame.videoData = videoData;
		}
		
		public function showActressDetailFrame(actressData:ActressData = null):void{
			if(!_actressDetailFrame) _actressDetailFrame = new ActressDetailFrame();
			PopUpUtil.instance.addPopUp(this._actressDetailFrame, this._uiRoot, true, 1);
			_actressDetailFrame.actressData = actressData;
		}
		
		public function showLoading():void{
			if(!_loading) _loading = new Loading();
			PopUpUtil.instance.addPopUp(this._loading, this._uiRoot, true, 1);
			_loading.autoProgress();
		}
		
		public function closeLoading():void{
			if(_loading){
				_loading.close();
			}
		}
		
		public static function get instance():UIManager{
			if(!_instance) _instance = new UIManager(new T());
			return _instance
		}
	}
}

final class T{};