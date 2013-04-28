import Graphics.UI.SDL 			as SDL
import Graphics.UI.SDL.TTF 		as SDLt
--import Graphics.UI.SDL.Color		--as SDLc
import Data.Word
import Graphics.UI.SDL.General		as SDLg

main ::IO ()
main = do
	SDL.init [SDL.InitEverything]
	SDL.setVideoMode 600 600 32 []
	SDL.setCaption "Video Test!" "video test"
	
	mainSurf <- getVideoSurface
	SDLt.init
	font <- openFont "FreeMono.ttf" 12
	let color = (Color 255 0 0)
	let rect = Just (Rect 0 0 300 300)
	text <- renderTextSolid font "hello world!" color
	blitSurface text rect mainSurf Nothing
	SDL.flip mainSurf

	eventLoop
	SDL.quit
	print "done"
	where
		eventLoop = SDL.waitEventBlocking >>= checkEvent
		checkEvent (KeyUp _)	= return ()
		checkEvent _		= eventLoop
