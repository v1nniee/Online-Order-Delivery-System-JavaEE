package model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2024-11-29T18:50:15")
@StaticMetamodel(Announcement.class)
public class Announcement_ { 

    public static volatile SingularAttribute<Announcement, Date> createdAt;
    public static volatile SingularAttribute<Announcement, Long> id;
    public static volatile SingularAttribute<Announcement, String> title;
    public static volatile SingularAttribute<Announcement, String> content;

}