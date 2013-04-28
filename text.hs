import Graphics.UI.SDL 			as SDL
import Graphics.UI.SDL.TTF 		as SDLt
import Data.Word
import Graphics.UI.SDL.General		as SDLg

main ::IO ()
main = do
	-- init everything
	SDL.init [SDL.InitEverything]
	SDLt.init

	-- set up window size
	SDL.setVideoMode 600 600 32 []
	
	mainSurf <- getVideoSurface
	SDLt.init
	font <- openFont "FreeMono.ttf" 12
	let color = (Color 255 0 0)
	let rect = Just (Rect 0 0 300 300)
	let offset = Just (Rect 0 0 0 0)
	text <- renderTextSolid font "hello world!" color
	blitSurface text rect mainSurf offset
	SDL.flip mainSurf

	let offset = Just (Rect 0 12 0 0)
	text <- renderTextSolid font "hello again!" color
	blitSurface text rect mainSurf offset
	SDL.flip mainSurf

	eventLoop
	SDL.quit
	print "done"
	where
		eventLoop = SDL.waitEventBlocking >>= checkEvent
		checkEvent (KeyUp _)	= return ()
		checkEvent _		= eventLoop
