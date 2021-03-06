package org.avManager.view
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import org.avManager.events.VideoEvent;
	import org.avManager.model.data.ActressData;
	import org.avManager.model.data.VideoData;
	import org.avManager.view.about.About;
	import org.avManager.view.actress.ActressCreator;
	import org.avManager.view.actress.ActressDetailFrame;
	import org.avManager.view.actress.DMMRankParser;
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
		
		private var _actressCreator:ActressCreator;
		
		private var _loading:Loading;
		
		private var _dmmRankParser:DMMRankParser;
		
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
			if(!_videoDetailFrame) {
				_videoDetailFrame = new VideoDetailFrame();
				_videoDetailFrame.addEventListener(VideoEvent.COVER_LOADED, onCoverLoaded);
			}
			PopUpUtil.instance.addPopUp(this._videoDetailFrame, this._uiRoot, true, 1);
			_videoDetailFrame.videoDataID = videoID;
			_videoDetailFrame.videoData = videoData;
		}
		
		protected function onCoverLoaded(event:VideoEvent):void
		{
			if(_actressDetailFrame){
				_actressDetailFrame.updateVideoData(event.videoData);
			}
		}
		
		public function showActressDetailFrame(actressData:ActressData = null):void{
			if(!_actressDetailFrame) _actressDetailFrame = new ActressDetailFrame();
			PopUpUtil.instance.addPopUp(this._actressDetailFrame, this._uiRoot, true, 1);
			_actressDetailFrame.actressData = actressData;
		}
		
		public function showLoading(autoProgress:Boolean = false, label:String = ''):void{
			if(!_loading) _loading = new Loading();
			_loading.show(this._uiRoot, label);
//			_loading.autoProgress();
		}
		
		public function closeLoading():void{
			if(_loading){
				_loading.close();
			}
		}
		
		public function showActressCreator():void{
			if(!_actressCreator) _actressCreator = new ActressCreator();
			PopUpUtil.instance.addPopUp(this._actressCreator, this._uiRoot, true, 1);
		}
		
		public function showDmmRankParser():void{
			if(!_dmmRankParser){
				_dmmRankParser = new DMMRankParser();
			}
			PopUpUtil.instance.addPopUp(this._dmmRankParser, this._uiRoot, true, 1);
		}
		
		public function closeDmmRankParser():void{
			if(_dmmRankParser){
				PopUpUtil.instance.removePopUp(_dmmRankParser, 1);				
			}
		}
		
		public static function get instance():UIManager{
			if(!_instance) _instance = new UIManager(new T());
			return _instance
		}
	}
}

final class T{};