Vim�UnDo� <�E�x�W6�<P��un��rO��P3
  F         res.redirect('/');  7         #       #   #   #    [;��    _�                           ����                                                                                                                                                                                                                                                                                                                           #                   V       [;��     �              <<<<<<< HEAD           'notify': {             sms: {                phoneNumber: number,               active: smsact             },             slack: {                 },             telegram: {   0            msg_id: user.notify.telegram.msg_id,   ,            auth: user.notify.telegram.auth,               active: tgact             }   =======5�_�                           ����                                                                                                                                                                                                                                                                                                                                              V       [;��    �              >>>>>>> master5�_�                   �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;��     �   �   �          <<<<<<< HEAD5�_�                    �       ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;��     �   �   �                var number;5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;��     �   �   �          =======5�_�                    �   
    ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;��     �   �   �  E      
          �   �   �  D    5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;��    �   �   �          >>>>>>> master5�_�                   2       ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;��    �  1  2              });5�_�                   6       ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;��     �  6  8  D            �  6  8  C    5�_�                   7       ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;��     �  6  8  D          }5�_�                   7       ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;��    �  6  8  D          }})5�_�                    �   p    ����                                                                                                                                                                                                                                                                                                                                                             [;��    �   �   �  D      q      var on, delayon, contacton, periscopeon, importon, bccon, ccon, mailon, responderon, vipon, blackon, keyon;5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �   "       �          V   "    [;��    �   �   �                }�   �   �          "        number = data.phonenumber;�   �   �                else {�   �   �                }�   �   �          .        number == user.notify.sms.phoneNumber;�   �   �          _      if (data.phonenumber == null || data.phonenumber == undefined || data.phonenumber == ""){5�_�                   �        ����                                                                                                                                                                                                                                                                                                                            �   "       �          V   "    [;�     �   �   �  D    5�_�                    �       ����                                                                                                                                                                                                                                                                                                                            �   "       �          V   "    [;�    �   �   �  F              �   �   �  E    5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �          �           v       [;�    �   �   �  F                if (debug){   9        console.info("Phonenumber: " + data.phonenumber);   @        console.log("DB Phone: " + user.notify.sms.phoneNumber);         }5�_�                    �        ����                                                                                                                                                                                                                                                                                                                                                             [;�    �  8  :              }});�  7  9            });�  6  8              }�  5  7                res.redirect('/');�  4  6          
    else {�  3  5              }�  1  3          	      });�  0  2          	        }�  /  1          $          res.redirect('/settings');�  .  0          D          req.flash('Success', 'Sucess! Your settings were saved.');�  -  /                  else{�  ,  .          	        }�  +  -          2          console.log('Error save user settings');�  *  ,                  if (err){�  )  +                }}, function(err, user) {�  (  *                  smsact: smsact�  '  )                  tgact: tgact,�  &  (          #        ignoreMailingLists: mailon,�  %  '                  ignoreCC: ccon,�  $  &                  ignoreBCC: bccon,�  #  %          !        'config.keywords': keyon,�  "  $          '        'config.Keyphrases': splitKeys,�  !  #          J        'config.blacklist': data.blacklist.split(' ').join('').split(','),�     "          J        'config.whitelist': data.whitelist.split(' ').join('').split(','),�    !          3        'config.periscopeTime': data.periscopeTime,�               (        'config.periscope': periscopeon,�              *        'config.blacklistToggle': blackon,�              (        'config.whitelistToggle': vipon,�              (        'config.responder': responderon,�              
        },�              D          message2: data.message2.replace(/(?:\r\n|\r|\n)/g, '<br>')�              E          message1: data.message1.replace(/(?:\r\n|\r|\n)/g, '<br>'),�                        prefix: data.prefix,�                      responseMessage: {�              
        },�              '          phoneNumber: data.phonenumber�                      'notify.sms': {�              ,        // Do not delete structure of notify�                       importantOnly: importon,�              $        restrictContacts: contacton,�              "        delaytime: data.delaytime,�                      delayEnabled: delayon,�                       notifyop: data.notifyop,�                      outriggerEnabled: on,�              >      user = User.findOneAndUpdate({id: req.user.id }, {$set:{�  
            J      // If the user is logged in, set them as the creator of the contact.�    
                }�    	          0        splitKeys = data.Keyphrases.split(', ');�              (      if (data.Keyphrases != undefined){�                    var splitKeys;�                    }�              C        console.log(data.whitelist.split(' ').join('').split(','));�                     if (debug){�   �            
      // }�   �             !      //   data.delaytime = 0.25;�   �   �          $      // if (data.delaytime < 0.25){�   �   �                }�   �   �                  smsact = true;�   �   �                  tgact = false;�   �   �          '      else if (data.notifyop == 'SMS'){�   �   �                }�   �   �                  smsact = false;�   �   �                  tgact = true;�   �   �          '      if (data.notifyop == 'Telegram'){�   �   �                var tgact, smsact;�   �   �                }�   �   �                  mailon = false;�   �   �                else {�   �   �                }�   �   �                  mailon = true;�   �   �          1      if (data.ignoreMailingListsSwitch == 'on'){�   �   �                }�   �   �                  bccon = false;�   �   �                else {�   �   �                }�   �   �                  bccon = true;�   �   �          (      if (data.ignoreBCCSwitch == 'on'){�   �   �                }�   �   �                  ccon = false;�   �   �                else {�   �   �                }�   �   �                  ccon = true;�   �   �          '      if (data.ignoreCCSwitch == 'on'){�   �   �                }�   �   �                  importon = false;�   �   �                else {�   �   �                }�   �   �                  importon = true;�   �   �          )      if (data.importanceSwitch == 'on'){�   �   �                }�   �   �                  contacton = false;�   �   �                else {�   �   �                }�   �   �                  contacton = true;�   �   �          &      if (data.contactSwitch == 'on'){�   �   �                }�   �   �                  delayon = false;�   �   �                else {�   �   �                }�   �   �                  delayon = true;�   �   �          $      if (data.delaySwitch == 'on'){�   �   �                }�   �   �                  periscopeon = false;�   �   �                else {�   �   �                }�   �   �                  periscopeon = true;�   �   �          (      if (data.periscopeSwitch == 'on'){�   �   �          0      // Save the masterSwitch data as a boolean�   �   �                }�   �   �                  blackon = false;�   �   �                else {�   �   �                }�   �   �                  blackon = true;�   �   �          $      if (data.blackSwitch == 'on'){�   �   �                }�   �   �                  vipon = false;�   �   �                else {�   �   �                }�   �   �                  vipon = true;�   �   �          "      if (data.vipSwitch == 'on'){�   �   �                }�   �   �                  responderon = false;�   �   �                else {�   �   �                }�   �   �                  responderon = true;�   �   �          (      if (data.responderSwitch == 'on'){�   �   �                }�   �   �                  keyon = false;�   �   �                else {�   �   �                }�   �   �                  keyon = true;�   �   �          "      if (data.keySwitch == 'on'){�   �   �                }�   �   �          ?        require('./publisher').sendMessage(req.user.id, false);�   �   �          T        // setTimeout(require('./publisher').sendMessage(req.user.id, false), 1500);�   �   �          )        console.log('Master switch off');�   �   �                  on = false;�   �   �                else {�   �   �                }�   �   �          >        require('./publisher').sendMessage(req.user.id, true);�   �   �          S        // setTimeout(require('./publisher').sendMessage(req.user.id, true), 1500);�   �   �          (        console.log('Master switch on');�   �   �                  on = true;�   �   �          %      if (data.masterSwitch == 'on'){�   �   �          0      // Save the masterSwitch data as a boolean�   �   �          
      // }�   �   �          %      //   number = data.phonenumber;�   �   �                // else {�   �   �          
      // }�   �   �          1      //   number == user.notify.sms.phoneNumber;�   �   �          b      // if (data.phonenumber == null || data.phonenumber == undefined || data.phonenumber == ""){�   �   �                }�   �   �          	        }�   �   �          B          console.log("DB Phone: " + user.notify.sms.phoneNumber);�   �   �          ;          console.info("Phonenumber: " + data.phonenumber);�   �   �                  if (debug){�   �   �                  });�   �   �                    }�   �   �                      }�   �   �          =              data.phonenumber = user.notify.sms.phoneNumber;�   �   �          -            if (user.notify.sms.phoneNumber){�   �   �                    else {�   �   �                    }�   �   �                      console.error(err);�   �   �                    if (err){�   �   �          4        User.findOne({id: user.id}, (err, user) => {�   �   �          C      if (data.phonenumber == undefined || data.phonenumber == ""){�   �   �          N      // Fix phonenumber getting deleted when switching notifications channels�   �   �          y      var on, delayon, contacton, periscopeon, importon, bccon, ccon, mailon, responderon, vipon, blackon, keyon, number;�   �   �                const data = req.body;�   �   �          :    User.findOne({id: req.user.id }, function(err, user) {5�_�                   4       ����                                                                                                                                                                                                                                                                                                                                                             [;�y     �  3  5  F            }5�_�                   4       ����                                                                                                                                                                                                                                                                                                                            �          �           v       [;�     �  4  6  G            �  4  6  F    5�_�                   :       ����                                                                                                                                                                                                                                                                                                                            �          �           v       [;�     �  9  ;  G        }});5�_�      !             :       ����                                                                                                                                                                                                                                                                                                                            �          �           v       [;�     �  9  ;  G       }});5�_�       "           !  :       ����                                                                                                                                                                                                                                                                                                                            �          �           v       [;�     �  9  :           });5�_�   !   #           "  6        ����                                                                                                                                                                                                                                                                                                                            �          �           v       [;��    �  8  :              });�  7  9          	        }�  6  8                    res.redirect('/');�  5  7                  else {5�_�   "               #  7       ����                                                                                                                                                                                                                                                                                                                            �          �           v       [;��    �  6  8  F            res.redirect('/');5�_�                    :       ����                                                                                                                                                                                                                                                                                                                            �          �           v       [;�     �  9  ;  G       });5�_�                   :       ����                                                                                                                                                                                                                                                                                                                            �          �           v       [;�    �  9  ;        5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �   "       �          V   "    [;��     �   �   �        5�_�      
             �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;��     �   �   �        5�_�                 
   �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;��     �   �   �        5�_�             
      �        ����                                                                                                                                                                                                                                                                                                                                                             [;��   	 �   �   �        5�_�      	                     ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;��     �         C      1}/* Copyright (C) Outrigger - All Rights Reserved5�_�                  	           ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;��   
 �         C      0/* Copyright (C) Outrigger - All Rights Reserved5�_�                   �       ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;�     �   �   �        5�_�                   0       ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;�    �  /  1        5�_�                    4       ����                                                                                                                                                                                                                                                                                                                            �           �           V        [;�c    �  3  5        5��