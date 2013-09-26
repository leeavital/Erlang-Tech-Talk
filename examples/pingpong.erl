-module( pingpong ).
-compile(export_all).



ping( ) ->
   PongRef = spawn( pingpong, pong, [ self() ] ),
   ping_loop( PongRef ).

ping_loop( PongRef ) ->
   
   timer:sleep( 300 ),
   PongRef ! {self(), ping},
      
   receive 
	  {PongRef, pong} ->
		 io:format( "ping~n"),
		 ping_loop( PongRef )
   end.


pong( PingRef ) ->

   receive
	  {PingRef, ping} ->
		 io:format( "pong~n"),
		 timer:sleep( 400 ),
		 PingRef ! {self(), pong},
		 pong( PingRef ) 
   end.
