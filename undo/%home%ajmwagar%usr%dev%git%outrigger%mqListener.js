Vim�UnDo� �N��{ߔ�r��^{�g��������	B��   *   sock.subscribe('kitty cats');   $                          [;��    _�                             ����                                                                                                                                                                                                                                                                                                                                                             [;��    �                   5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             [;��     �               sock.subscribe('kitty cats');5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             [;��     �               sock.subscribe('');5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             [;��    �               sock.subscribe('noty');5�_�                    
        ����                                                                                                                                                                                                                                                                                                                                                             [;��     �   
          �   
          5�_�                    
       ����                                                                                                                                                                                                                                                                                                                                                             [;��     �   	   
          W  console.log('received a message related to:', topic, 'containing message:', message);5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V       [;��     �                   }�                /     sms.notify(user, msg.split('*').join(''));�                $   else if (user.notifyop == 'SMS'){�                   }�                     gram.notify(user, msg);�                $   if (user.notifyop == 'Telegram'){5�_�      	                      ����                                                                                                                                                                                                                                                                                                                                                V       [;��     �                 �             5�_�      
           	          ����                                                                                                                                                                                                                                                                                                                                                V       [;��    �                 console.log(msg)5�_�   	              
          ����                                                                                                                                                                                                                                                                                                                                                V       [;��   	 �                 console.log(msg);5�_�   
                         ����                                                                                                                                                                                                                                                                                                                                                  V        [;�;     �                });�                   // }�                2   //   sms.notify(user, msg.split('*').join(''));�                '   // else if (user.notifyop == 'SMS'){�                   // }�                   //   gram.notify(user, msg);�                '   // if (user.notifyop == 'Telegram'){�                    console.log(msg);�                T   var msg = message.split('<').join('').split('>').join('').split('\'').join('\'');�                    // notify�                  �                 �                   var message = data.message;�                   var user = data.user;�                 �                %   var data = json.parse(dataString);�                >   var dataString = Buffer.from(b64string, 'base64'); // Ta-da�                   var b64string = message;�                    // Parse data�   
              �   	                  console.log("Got message!");�      
          -sock.on('message', function(topic, message) {�      	           �                1console.log('Subscriber connected to port 3000');�                sock.subscribe('notify');�                %sock.connect('tcp://127.0.0.1:3000');�                 �                  , sock = zmq.socket('sub');�                var zmq = require('zeromq')�                 // subber.js5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        [;�<     �                 // });�               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        [;�=     �                  �               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        [;�A    �         *      /h/ });5�_�                    $       ����                                                                                                                                                                                                                                                                                                                                                  V        [;��     �   #   %   *      sock.subscribe('kitty cats');5�_�                     $       ����                                                                                                                                                                                                                                                                                                                                                  V        [;��    �   #   %   *      sock.subscribe('');5��