Vim�UnDo� ����u�=�S���<3�TMv �M��d7�(�   `                                  [R]�    _�                     <        ����                                                                                                                                                                                                                                                                                                                                                             [R]'     �   ;   <          F      require('./client/client').outrigger(user, oauth2client, false);5�_�                    ;       ����                                                                                                                                                                                                                                                                                                                                                             [R](     �   :   ;                // Dive! Dive! Dive!5�_�                    :        ����                                                                                                                                                                                                                                                                                                                                                             [R](     �   :   >   �            �   :   <   �    5�_�                    A       ����                                                                                                                                                                                                                                                                                                                                                             [R]6     �   @   B   �      *      console.log('Watching like a hawk');5�_�                    A       ����                                                                                                                                                                                                                                                                                                                                                             [R]7    �   @   B   �            console.log('');5�_�                    0       ����                                                                                                                                                                                                                                                                                                                                                             [R]>     �   0   3   �          �   0   2   �    5�_�                    /       ����                                                                                                                                                                                                                                                                                                                                                             [R]C     �   .   0   �      3      keyFilename: '../Outrigger-913bba9fd2ae.json'5�_�      	              )       ����                                                                                                                                                                                                                                                                                                                            *          )          V       [R]F     �   (   )          4    // require('./client/pubsub').getTopic('gmail');   6    // require('./client/pubsub').getTopic('enabler');5�_�      
           	   )       ����                                                                                                                                                                                                                                                                                                                            )          )          V       [R]G     �   (   )          S    setTimeout(require('./client/responder').listenForMessages, 5000, 'Outrigger');5�_�   	              
   ,       ����                                                                                                                                                                                                                                                                                                                            )          *          v       [R]Y     �   +   -   �            keyFilename: ''5�_�   
                 ,       ����                                                                                                                                                                                                                                                                                                                            )          *          v       [R]Y     �   +   -   �            keyFilename: '5�_�                    ,       ����                                                                                                                                                                                                                                                                                                                            )          *          v       [R]Z    �   +   -   �            keyFilename: 5�_�                    U        ����                                                                                                                                                                                                                                                                                                                            U          �          V       [R]�     �   T   U       V   /**   " * checkUser returns a bool value.   : * @returns {bool} true - whether this user is new or not.    */   function checkUser(cb){   +  console.log('Checking against id: ' + id)   V  mongoose.connection.db.collection('users').find({id: this.id}, function (err, user){   !    console.log('Users' + users);       if (user.length != 0){         //return true;         cb(false, user);   
    }else{         //return false;         cb(true,true);       }     });   };       /**    * getUser returns a user.   - * @returns {var} user - json object of user.    */   function getUser(cb){   g  mongoose.connection.db.collection('users').find({id: this.id}).limit(1).toArray(function (err, user){       if (!user.length == 0){         cb(user[0],null);         //return docs[0];       }   	    else{         cb(false,user);         //return null;       }     });   };       /**   ; * queueNotification: Adds a new notification to the queue.   ; * @param {string} message - a message to be added to queue   @ * @param {string} id - req.session.id to get user from mongodb.   - * @returns {var} user - json object of user.    */   (function queueNotification(message, id){   -  //TODO Add a new notification to the queue.   3  var queue = mongoDbQueue(con.db, (id + 'Queue'));   '  queue.add(message, function(err, id){       if (err){         console.log(err);       }   	    else{   ,      console.log('Message added to queue');       }         });           };           /**   / * gets a message from the queue and removes it   2 * @param {string} id - the profile id of the user   ? * @returns {string} message - the message value from the queue    * */       function getMessage(id){   3  var queue = mongoDbQueue(con.db, (id + 'Queue'));      queue.get(function(err, msg) {   *    queue.ack(msg.ack, function(err, id) {   9      // this message has now been removed from the queue         if (err){           console.log(err);         }         else{   2        console.log('Message removed from queue');   
      }});       if (err){         console.log(err);       }   	    else{   2      console.log('Message proccesed from queue');           }       console.log(msg);       return msg;     });   };5�_�                    `        ����                                                                                                                                                                                                                                                                                                                            U          U          V       [R]�     �   _   `            getMessage: getMessage,5�_�                     ^       ����                                                                                                                                                                                                                                                                                                                            U          U          V       [R]�    �   ]   ^          '  queueNotification: queueNotification,5��