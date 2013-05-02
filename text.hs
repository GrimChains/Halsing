import Graphics.UI.SDL 			as SDL
import Graphics.UI.SDL.TTF 		as SDLt
import Graphics.UI.SDL.General		as SDLg

main ::IO ()
main = do
	-- init everything
	SDL.init [SDL.InitEverything]
	SDLt.init

	-- set up window size
	SDL.setVideoMode 600 600 32 []

	-- set up constants
	let size	= 12
	let color	= (Color 255 0 0)
	let rect	= Just (Rect 0 0 600 600)
	mainSurf	<- getVideoSurface
	font		<- openFont "FreeMono.ttf" size

	-- build text lines
	buildText "Line 1" 0 size font mainSurf color
	buildText "Line 2" 1 size font mainSurf color
	buildText "Line 3" 2 size font mainSurf color

	eventLoop
	SDL.quit
	print "done"
	where
		eventLoop = SDL.waitEventBlocking >>= checkEvent
		checkEvent (KeyUp _)	= return ()
		checkEvent _		= eventLoop


-- Message -> Pixel offset -> Text font -> Base Surface -> Text color -> Output
buildText :: String -> Int -> Int -> Font -> Surface -> Color -> IO()
buildText message line size font mainSurf color = do
	-- set up constants
	let offset	= Just (Rect 0 (size * line) 0 0)
	let rect	= Just (Rect 0 0 600 600)

	-- render our text
	text <- renderTextSolid font message color
	blitSurface text rect mainSurf offset
	SDL.flip mainSurf
	return()
