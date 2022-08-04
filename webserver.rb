require 'json'
require 'socket'  # En la biblioteca nativa de ruby
require 'set'
server = TCPServer.new('localhost',8085)
begin
  while true do
    connClient     = server.accept()
    request_method = connClient.gets().split[0]
    if Set["GET","HEAD","POST","PUT","DELETE","CONNECT","OPTIONS","TRACE","PATCH"].include?(request_method) #Cualquier HTTP request
        connClient.puts("HTTP/1.1 200\r\n\r\n#{JSON.generate({random: rand(101)})}") #Formato de HTTP response con codigo 200 (OK)
    connClient.close() #HTTP no es persistente, asi que cerramos la conexión despues del mensaje
    end
  end
rescue Interrupt  # Para que no aparezca un error al cerrar el server con ctrl + c
end 