Vim�UnDo� �%�4u�5���M"%◶k��n������!��@  "                       +       +   +   +    [S�@    _�                     �        ����                                                                                                                                                                                                                                                                                                                                                             [S�     �   �   �          #          accessToken: accessToken,   $          refreshToken: refreshToken5�_�                    �       ����                                                                                                                                                                                                                                                                                                                                                             [S�     �   �   �  \      
        },5�_�                   �        ����                                                                                                                                                                                                                                                                                                                                                             [S�#     �   �   �       .           _id: req.session._id,           tokens: {           kk},           responseMessage: {              prefix: "Auto-Reply:",   �          message1: "Thank you for the message.\n\nI am currently away from email.\n\nIf your message is urgent, please click below to notify me:",   ;          message2: "Thank you, \n\n" + profile.displayName   
        },           id: profile.id,   "        name: profile.displayName,   '        email: profile.emails[0].value,   0        outriggerEnabled: config.get('ENABLED'),   G        topic: ('projects/outrigger-170622/topics/gmail' + profile.id),           config: {             periscope: true,             periscopeTime: 15,             periscopeList: [],             whitelist: [],             blacklist: []   
        },           idBlacklist: [],            restrictContacts: false,           delayedEmails: [],           delaytime: 4,           delayEnabled: true,           importantOnly: false,           isActive: false,           notify: {             telegram: {   8            auth: crypto.randomBytes(6).toString('hex'),               active: false             },             sms: {               active: false,   "            phonenumber: undefined             }       
        },   *        //Leave disabled until implemented           aiEnabled: false,           useCalendar: false,           ignoreBCC: true,           ignoreCC: true,   !        ignoreMailingLists: true,           tgact: true,           smsact: false5�_�                    �       ����                                                                                                                                                                                                                                                                                                                                                             [S�$     �   �   �  .    5�_�                    �       ����                                                                                                                                                                                                                                                                                                                                                             [S�(     �   �   �  1    �   �   �  0              �   �   �  /    5�_�                    �       ����                                                                                                                                                                                                                                                                                                                                                             [S�-     �   �   �  5      
          �   �   �  4    �   �   �  3              �   �   �  2    5�_�                    �   	    ����                                                                                                                                                                                                                                                                                                                                                             [S�D    �   �   �  6      	        }5�_�         
                  ����                                                                                                                                                                                                                                                                                                                                                  V        [S�g     �                 0/* Copyright (C) Outrigger - All Rights Reserved   K * Unauthorized copying of this file, via any medium is strictly prohibited    * Proprietary and confidential   4 * Written by Avery Wagar <avery@wagar.cc>, May 2018    */    5�_�                       #    ����                                                                                                                                                                                                                                                                                                                                                  V        [S�p     �        0      -const mongoose = require('../models/models');5�_�                       #    ����                                                                                                                                                                                                                                                                                                                                                  V        [S�p     �        0      ,const mongoose = require('../modelsmodels');5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        [S�s     �        0      !const mongo = require('./mongo');5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        [S�|    �                 const mongo = require('./mongo')5�_�                    �       ����                                                                                                                                                                                                                                                                                                                                                             [S�q    �   �   �          /    'https://www.googleapis.com/auth/contacts',5�_�                    �       ����                                                                                                                                                                                                                                                                                                                                                             [S�|    �   �   �          %    'https://www.google.com/m8/feeds'5�_�                    �       ����                                                                                                                                                                                                                                                                                                                                                             [S�}   	 �   �   �  -          'https://mail.google.com/',5�_�                    �       ����                                                                                                                                                                                                                                                                                                                                                             [S��     �   �   �  -      Q              pubsub.topic('gmail').createSubscription('Outrigger' + profile.id);5�_�                    �       ����                                                                                                                                                                                                                                                                                                                                                             [S��     �   �   �          S              skkubsub.topic('gmail').createSubscription('Outrigger' + profile.id);5�_�                    �       ����                                                                                                                                                                                                                                                                                                                            �          �          V       [S��   
 �   �   �          ;            const PubSub = require(`@google-cloud/pubsub`);               // Creates a client   '            const pubsub = new PubSub({   5              projectId: config.get('GCLOUD_PROJECT')               });5�_�                          ����                                                                                                                                                                                                                                                                                                                            �          �          V       [S�     �              $    if (beta.check(req.user.email)){5�_�                   	       ����                                                                                                                                                                                                                                                                                                                                    	          V       [S�     �    	              }   
    else {         redirect = '/settings';          // redirect = '/noinvite';       }5�_�                          ����                                                                                                                                                                                                                                                                                                                           	         	          V       [S�     �      !            redirect = '/settings';5�_�                          ����                                                                                                                                                                                                                                                                                                                           	         	          V       [S�     �              $      // res.send({user: req.user});5�_�                          ����                                                                                                                                                                                                                                                                                                                                              V       [S�    �              %    // FIXME REMOVE ME AFTER BETA!!!!5�_�                          ����                                                                                                                                                                                                                                                                                                                                              V       [S�%     �                redirect = '/settings';5�_�                          ����                                                                                                                                                                                                                                                                                                                                              V       [S�'    �                redirect = '/';5�_�                    }       ����                                                                                                                                                                                                                                                                                                                                              V       [S��    �   }            
          �   }         5�_�                    ~       ����                                                                                                                                                                                                                                                                                                                                              V       [S��    �   }   �                   name: profile.name5�_�      !               ~        ����                                                                                                                                                                                                                                                                                                                                       ~           V        [S�[     �   }   ~          $          name: profile.displayName,             id: profile.id5�_�       "           !   |        ����                                                                                                                                                                                                                                                                                                                            ~           ~           V        [S�[     �   |         �   |   }      5�_�   !   #           "   }        ����                                                                                                                                                                                                                                                                                                                            }   
       ~   
       V   
    [S�]    �   |     !      $          name: profile.displayName,             id: profile.id5�_�   "   $           #   ~       ����                                                                                                                                                                                                                                                                                                                            }   
       ~   
       V   
    [S�`     �   }     !              id: profile.id5�_�   #   &           $   ~       ����                                                                                                                                                                                                                                                                                                                            }   
       ~   
       V   
    [S�a    �   ~   �  "              �   ~   �  !    5�_�   $   '   %       &          ����                                                                                                                                                                                                                                                                                                                            }   
       ~   
       V   
    [S��    �   ~   �  "              email: 5�_�   &   (           '      #    ����                                                                                                                                                                                                                                                                                                                            }   
       ~   
       V   
    [S��    �   ~   �  "      #        email: profile.addresses[0]5�_�   '   )           (          ����                                                                                                                                                                                                                                                                                                                            }   
       ~   
       V   
    [S��     �   ~   �  "      $        email: profile.addresses[0];5�_�   (   *           )          ����                                                                                                                                                                                                                                                                                                                            }   
       ~   
       V   
    [S��     �   ~   �  "              email: profile.[0];5�_�   )   +           *           ����                                                                                                                                                                                                                                                                                                                            }   
       ~   
       V   
    [S��    �   ~   �  "      !        email: profile.emails[0];5�_�   *               +      '    ����                                                                                                                                                                                                                                                                                                                            }   
       ~   
       V   
    [S�?    �   ~   �  "      '        email: profile.emails[0].value;5�_�   $           &   %   �        ����                                                                                                                                                                                                                                                                                                                            }   
       ~   
       V   
    [S��     �   �   �                  if (newUser){�   �   �                    if (debug){�   �   �          $            console.log('New user');�   �   �                    }�   �   �          0          authedUser.save(function(err, result){�   �   �                      if(err){�   �   �                        if (debug){�   �   �          ,                console.log('>>>>>> Error');�   �   �          =                console.log('Error saving user to database');�   �   �          !                console.log(err);�   �   �                        }�   �   �                      }�   �   �                      else�   �   �                      {�   �   �          J              // console.log('>>>>>> ' + JSON.stringify(result, null, 4));�   �   �          F              mongoose.User.findOne({id: profile.id}, (err, user) => {�   �   �          '                res.locals.user = user;�   �   �          2                console.log(res.locals.user.name);�   �   �                        });�   �   �                      }�   �   �          <            // Redirect new users since we are still in beta�   �   �                    });�   �   �          	        }�   �   �                  else�   �   �          	        {�   �   �                    if (debug){�   �   �          (            console.log('Not new user');�   �   �                    }�   �   �                    if (refreshToken){�   �   �          �            mongoose.User.findOneAndUpdate({id: profile.id}, {$set:{"tokens.accessToken": accessToken, "tokens.refreshToken": refreshToken}}, function (err, res){�   �   �                         if (err && debug){�   �   �          8                console.error('Error updating tokens.');�   �   �                        }�   �   �                      });�   �   �                    }�   �   �                    else {�   �   �          }            mongoose.User.findOneAndUpdate({id: profile.id}, {$set:{"tokens.accessToken": accessToken}}, function (err, res){�   �   �                         if (err && debug){�   �   �          8                console.error('Error updating tokens.');�   �   �                        }�   �   �                      });�   �   �          D            mongoose.User.findOne({id: profile.id}, (err, user) => {�   �   �                        if (user){�   �   �          '                res.locals.user = user;�   �   �                        }�   �   �                      });�   �   �                    }�   �   �          	        }5�_�                    y       ����                                                                                                                                                                                                                                                                                                                                              V       [S��     �   x   z         '      cb(null, extractProfile(rofile));5�_�          	      
           ����                                                                                                                                                                                                                                                                                                                                                             [S�e     �         6       5�_�              
   	   �   
    ����                                                                                                                                                                                                                                                                                                                                                             [S�J     �   �   �  6              },t5�_�                    �   )    ����                                                                                                                                                                                                                                                                                                                                                             [S�     �   �   �  \      =      var authedUser = new mongoose.User(id: req.session._id,5��