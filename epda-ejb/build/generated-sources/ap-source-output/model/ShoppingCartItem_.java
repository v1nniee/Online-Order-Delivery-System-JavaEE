package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Product;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2024-11-29T18:50:15")
@StaticMetamodel(ShoppingCartItem.class)
public class ShoppingCartItem_ { 

    public static volatile SingularAttribute<ShoppingCartItem, Product> product;
    public static volatile SingularAttribute<ShoppingCartItem, Integer> quantity;
    public static volatile SingularAttribute<ShoppingCartItem, Long> shoppingCartItemId;

}