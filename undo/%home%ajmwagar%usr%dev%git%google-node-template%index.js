Vim�UnDo� �x&ݺ~�T_#U��`�Q���Q�rm{�^@   �                  $       $   $   $    [R_�    _�                     �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �          $app.get('/noinvite', (req, res) => {     res.render('noinvite.pug');   });5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �       /   >app.get('/notify/:token/:index/:message', function(req, res) {            2  var notifier = require('./lib/notify/notifier');     async.waterfall([       // Check link        function (done){         if (debug){   &        console.log(req.params.token);         }   J      User.findOne({ notifylink: req.params.token }, function(err, user) {           if (!user) {   D          req.flash('error', 'Notification has already been sent.');   .          res.locals.messageHeader = 'Error!';   ?          res.locals.message = 'Notification link has expired';   $          res.render('notify.pug', {   $            messageHeader: 'Error!',   5            message: 'Notification link has expired.'             });   )          //return res.redirect('/home');   	        }           else {   8          // FIXME Crashes with wrong final block-length             try {   �            notifier.notify(user, decodeURIComponent(crypt.decrypt(req.params.message)).replace(new RegExp("\\+","g"),' ').replace(new RegExp("\\%2F", "g"), '/'));             }             catch (err){               if (err){   !              console.error(err);               }                 }   i          User.findOneAndUpdate({notifylink: req.params.token}, {$pull: {notifylink: req.params.token}});             done(err, user);   5          req.flash('success', 'Notification sent.');   0          res.locals.messageHeader = 'Success!';   =          res.locals.message = 'Notification has been sent.';   $          res.render('notify.pug', {   '            //messageHeader: 'Success!,   2            message: 'Notification has been sent.'             });   	        }   	      });       }         ]);   });5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �           5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �           5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �          // Redirect / to home   // app.get('/', (req, res) => {    //   console.log('redirecting');   //   // res.redirect('/home');   // });5�_�      
              �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �           5�_�                
   �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �      // app.use((req, res) => {5�_�   
                 �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �      / app.use((req, res) => {5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �      '  // res.status(404).redirect('/home');5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �      & // res.status(404).redirect('/home');5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �      %// res.status(404).redirect('/home');5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �      $/ res.status(404).redirect('/home');5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �      # res.status(404).redirect('/home');5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �      // });5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �      / });5�_�                    �   "    ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�    �   �   �   �      %   res.status(404).redirect('/home');5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �          =app.use('/settings', require('./controllers/settings/crud'));5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �    �   �   �   �    5�_�                   �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �          
//settings5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �    �   �   �   �    5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�    �   �   �   �    5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �       �   �   �   �    5�_�                    �       ����                                                                                                                                                                                                                                                                                                                            �          �          V       [R\�     �   �   �          // TODO Blog    @// app.use('/contacts', require('./controllers/contacts/crud'));       // TODO FAQ    "// app.use('/faq', (req, res) => {   //   res.render('faq.pug');   // });5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �          �          V       [R\�     �   �   �           5�_�                    �   	    ����                                                                                                                                                                                                                                                                                                                            �          �          V       [R\�    �   �   �   �      	// OAuth25�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �          �          V       [R\�     �   �   �   �       �   �   �   �    5�_�                     �        ����                                                                                                                                                                                                                                                                                                                            �          �          V       [R\�    �   �   �   �       �   �   �   �    5�_�      !               �        ����                                                                                                                                                                                                                                                                                                                            �   	       �           V   	    [R\�     �   �   �          //const options = {   3  //key: fs.readFileSync('./ssl/outriggerkey.pem'),   1  //cert: fs.readFileSync('./ssl/outrigger.pem'),   //};       //spdy    // .createServer(options, app)   ,  //.listen(config.get('PORT'), (error) => {      // if (error) {       //  console.error(error);        // return process.exit(1);       //} else {   F     // console.log('Listening on port: ' + config.get('PORT') + '.');      // }    // });    5�_�       "           !   �        ����                                                                                                                                                                                                                                                                                                                            �   	       �           V   	    [R\�     �   �   �          // local https5�_�   !   #           "   �        ����                                                                                                                                                                                                                                                                                                                            �   	       �           V   	    [R\�    �   �   �           5�_�   "   $           #   	        ����                                                                                                                                                                                                                                                                                                                            �   	       �           V   	    [R\�    �      	          // Outrigger Modules5�_�   #               $           ����                                                                                                                                                                                                                                                                                                                                                             [R_�    �                0const crypt        = require('./lib/encyption');5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �      sjj/settings5�_�      	      
      �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �      / Basic 404 handler5�_�                  	   �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �       Basic 404 handler5�_�                    �        ����                                                                                                                                                                                                                                                                                                                            �           �           V        [R\�     �   �   �   �      jk5��