# GsPipe, a Simple GenStage supervised pipeline

A simple GenStage demo application, with multiple consumers.

The queue worker is an ets queue.

Sample usage:

```elixir
$ iex -S mix
Erlang/OTP 21 [erts-10.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe]


14:47:45.861 [debug] #PID<0.172.0>: Elixir.GsPipe.Queue started.
 
14:47:45.868 [debug] #PID<0.174.0>: Elixir.GsPipe.Pipeline.Producer started.
 
14:47:45.872 [debug] #PID<0.175.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.872 [debug] #PID<0.176.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.872 [debug] #PID<0.177.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.872 [debug] #PID<0.178.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.872 [debug] #PID<0.179.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.872 [debug] #PID<0.180.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.872 [debug] #PID<0.181.0>: Elixir.GsPipe.Pipeline.Worker started.

14:47:45.872 [debug] #PID<0.182.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.872 [debug] #PID<0.183.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.872 [debug] #PID<0.184.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.872 [debug] #PID<0.185.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.872 [debug] #PID<0.186.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.873 [debug] #PID<0.187.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.873 [debug] #PID<0.188.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.873 [debug] #PID<0.189.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.873 [debug] #PID<0.190.0>: Elixir.GsPipe.Pipeline.Worker started.
 
14:47:45.873 [debug] #PID<0.191.0>: Elixir.GsPipe.Pipeline.Notifier started.
Interactive Elixir (1.7.3) - press Ctrl+C to exit (type h() ENTER for help)   
iex(1)> GsPipe.multi_enqueue 123, "koko"
```