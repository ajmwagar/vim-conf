Vim�UnDo� anb�;�lh礹��vmh�]��D�(PN��A                    +       +   +   +    [_�#    _�                             ����                                                                                                                                                                                                                                                                                                                                                             [_�]     �               5�_�                    
        ����                                                                                                                                                                                                                                                                                                                                                             [_ň     �   ;   =          export default ItemDetailPage;�   	             (class ItemDetailPage extends Component {5�_�                    %        ����                                                                                                                                                                                                                                                                                                                            4           %           V        [_Ō     �   $   %                <div>   \        <a href="/#/shop" style={style.a}><h2 style={style.title, style.right}>Back</h2></a>   (        <div style={ style.itemDetail }>   0          <div style={style.itemDetail.section}>   W            <img style={ style.itemDetail.itemImg } src={item.imgUrl} alt={item.name}/>             </div>   0          <div style={style.itemDetail.section}>   !            <h2>{item.brand}</h2>                <h3>{item.name}</h3>   2            <div style={style.itemDetail.options}>   M              <h4 style={ style.itemDetail.options.price }>${item.price}</h4>                 <OrderPlacer/>               </div>             </div>           </div>         </div>5�_�                    $       ����                                                                                                                                                                                                                                                                                                                            %           %           V        [_Ŏ     �   $   &   ,    5�_�                    %        ����                                                                                                                                                                                                                                                                                                                            &           &           V        [_Ő     �   $   <   -       �   %   &   -    5�_�                    %        ����                                                                                                                                                                                                                                                                                                                            <           <           V        [_ő    �   B   D          export default Contact;�   A   C          6// Export the component to use it in other components.�   ?   A          }�   >   @            }�   <   >              // <OrderPlacer>�   ;   =              )�   :   <          </div>�   9   ;          	  </form>�   7   9          (    <input type="submit" value="Submit">�   5   7          j    <textarea id="subject" name="subject" placeholder="Write something.." style="height:200px"></textarea>�   4   6          (    <label for="subject">Subject</label>�   2   4              </select>�   1   3          &      <option value="usa">USA</option>�   0   2          ,      <option value="canada">Canada</option>�   /   1          2      <option value="australia">Australia</option>�   .   0          (    <select id="country" name="country">�   -   /          (    <label for="country">Country</label>�   +   -          Q    <input type="text" id="lname" name="lastname" placeholder="Your last name..">�   *   ,          (    <label for="lname">Last Name</label>�   (   *          M    <input type="text" id="fname" name="firstname" placeholder="Your name..">�   '   )          )    <label for="fname">First Name</label>�   %   '          !  <form action="action_page.php">�   $   &          <div class="container">5�_�                    8   1    ����                                                                                                                                                                                                                                                                                                                            <           <           V        [_Ŷ     �   7   9   C      2              <input type="submit" value="Submit">5�_�      	              )   S    ����                                                                                                                                                                                                                                                                                                                            <           <           V        [_Ż     �   (   *   C      S          <input type="text" id="fname" name="firstname" placeholder="Your name..">5�_�      
           	   )   S    ����                                                                                                                                                                                                                                                                                                                            <           <           V        [_ż     �   (   *   C      T          <input type="text" id="fname" name="firstname" placeholder="Your name..">i5�_�   	              
   )   R    ����                                                                                                                                                                                                                                                                                                                            <           <           V        [_ż     �   (   *   C      S          <input type="text" id="fname" name="firstname" placeholder="Your name..">5�_�   
                 )   R    ����                                                                                                                                                                                                                                                                                                                            <           <           V        [_Ž    �   (   *   C      T          <input type="text" id="fname" name="firstname" placeholder="Your name..".>5�_�                    ,   Y    ����                                                                                                                                                                                                                                                                                                                            <           <           V        [_��     �   +   -   C      Y            <input type="text" id="lname" name="lastname" placeholder="Your last name..">5�_�                    ,   X    ����                                                                                                                                                                                                                                                                                                                            <           <           V        [_��    �   +   -   C      Y            <input type="text" id="lname" name="lastname" placeholder="Your last name..">5�_�                    +        ����                                                                                                                                                                                                                                                                                                                            <           <           V        [_��     �   B   D          %              export default Contact;�   A   C          D              // Export the component to use it in other components.�   ?   A                        }�   >   @                        }�   <   >                      // <OrderPlacer>�   ;   =                      )�   :   <                      </div>�   9   ;                        </form>�   7   9          3              <input type="submit" value="Submit"/>�   5   7          t              <textarea id="subject" name="subject" placeholder="Write something.." style="height:200px"></textarea>�   4   6          2              <label for="subject">Subject</label>�   2   4                        </select>�   1   3          0                <option value="usa">USA</option>�   0   2          6                <option value="canada">Canada</option>�   /   1          <                <option value="australia">Australia</option>�   .   0          2              <select id="country" name="country">�   -   /          2              <label for="country">Country</label>�   +   -          Z            <input type="text" id="lname" name="lastname" placeholder="Your last name.."/>�   *   ,          0            <label for="lname">Last Name</label>5�_�                            ����                                                                                                                                                                                                                                                                                                                            <           <           V        [_��     �                3import OrderPlacer from './components/orderPlacer';5�_�                            ����                                                                                                                                                                                                                                                                                                                            ;           ;           V        [_��    �                 5�_�                           ����                                                                                                                                                                                                                                                                                                                            :           :           V        [_��    �         A      -import style from './style'; // Import styles5�_�                    "        ����                                                                                                                                                                                                                                                                                                                            :           :           V        [_��     �   "   $   B            �   "   $   A    5�_�                           ����                                                                                                                                                                                                                                                                                                                            ;           ;           V        [_��     �                  render () {5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       [_��     �                  loadCommentsFromServer() {   B    var url = "http://10.0.0.145:3001/api/items/" + this.state.id;       console.log("Url: " + url);   !    axios.get(url).then( res => {         console.log(res.data);   %      this.setState({data: res.data})       } )         }         componentDidMount() {   "    this.loadCommentsFromServer();     }5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       [_��    �                /    console.log("Detail id: " + this.props.id);   1    this.state = { data: [], id: this.props.id };   I    this.loadCommentsFromServer = this.loadCommentsFromServer.bind(this);5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V       [_��     �                "    this.loadCommentsFromServer();       let item = this.state.data;5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       [_��     �         0        // �         /    5�_�                       
    ����                                                                                                                                                                                                                                                                                                                                                V       [_��     �         1    �         0      
  render()5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       [_��     �                  }5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V       [_��     �                 5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       [_��    �                
      <div5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       [_��     �         0            �         /    5�_�                       
    ����                                                                                                                                                                                                                                                                                                                                                V       [_��     �         1              �         0    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       [_��     �         1              <Header>5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V       [_��     �         2       �         1    5�_�      !                      ����                                                                                                                                                                                                                                                                                                                                                V       [_�     �         2      import Header from '../header'5�_�       "           !           ����                                                                                                                                                                                                                                                                                                                                                V       [_�     �   1   3          export default Contact;�   0   2          6// Export the component to use it in other components.�   .   0          }�   -   /            }�   +   -              // <OrderPlacer>�   *   ,              )�   )   +                </div>�   (   *                  </form>�   &   (          /          <input type="submit" value="Submit"/>�   $   &          p          <textarea id="subject" name="subject" placeholder="Write something.." style="height:200px"></textarea>�   #   %          .          <label for="subject">Subject</label>�   !   #                    </select>�       "          ,            <option value="usa">USA</option>�      !          2            <option value="canada">Canada</option>�                 8            <option value="australia">Australia</option>�                .          <select id="country" name="country">�                .          <label for="country">Country</label>�                X          <input type="text" id="lname" name="lastname" placeholder="Your last name.."/>�                .          <label for="lname">Last Name</label>�                T          <input type="text" id="fname" name="firstname" placeholder="Your name.."/>�                /          <label for="fname">First Name</label>�                '        <form action="action_page.php">�                      <div class="container">5�_�   !   #           "   ,        ����                                                                                                                                                                                                                                                                                                                                                V       [_�     �   +   ,                  // <OrderPlacer>5�_�   "   $           #   *        ����                                                                                                                                                                                                                                                                                                                                                V       [_�   	 �   *   ,   2              �   *   ,   1    5�_�   #   &           $   ,        ����                                                                                                                                                                                                                                                                                                                                                V       [_�    �   1   3          !          export default Contact;�   0   2          @          // Export the component to use it in other components.�   .   0                    }�   -   /                    }�   +   -          	        )5�_�   $   '   %       &          ����                                                                                                                                                                                                                                                                                                                                                V       [_�0     �         2      import Header from '../header';5�_�   &   (           '          ����                                                                                                                                                                                                                                                                                                                                                V       [_�1    �         2      import Header from './header';5�_�   '   )           (          ����                                                                                                                                                                                                                                                                                                                                                V       [_�9    �         2      import Header from './Header';5�_�   (   *           )           ����                                                                                                                                                                                                                                                                                                                                       )           V        [_�    �                )          <form action="action_page.php">       1            <label for="fname">First Name</label>   V            <input type="text" id="fname" name="firstname" placeholder="Your name.."/>       0            <label for="lname">Last Name</label>   Z            <input type="text" id="lname" name="lastname" placeholder="Your last name.."/>       0            <label for="country">Country</label>   0            <select id="country" name="country">   :              <option value="australia">Australia</option>   4              <option value="canada">Canada</option>   .              <option value="usa">USA</option>               </select>       0            <label for="subject">Subject</label>   r            <textarea id="subject" name="subject" placeholder="Write something.." style="height:200px"></textarea>       1            <input type="submit" value="Submit"/>                 </form>5�_�   )   +           *           ����                                                                                                                                                                                                                                                                                                                               	          	       V   	    [_�     �                        <div class="container">           </div>5�_�   *               +          ����                                                                                                                                                                                                                                                                                                                               	          	       V   	    [_�"    �             5�_�   $           &   %          ����                                                                                                                                                                                                                                                                                                                                                V       [_�     �         2      import Header from './header';5��