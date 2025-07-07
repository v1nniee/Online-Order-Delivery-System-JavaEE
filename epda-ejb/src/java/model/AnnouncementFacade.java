/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author vinni
 */
@Stateless
public class AnnouncementFacade extends AbstractFacade<Announcement> {

    @PersistenceContext(unitName = "epda-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AnnouncementFacade() {
        super(Announcement.class);
    }
    
    public void create(Announcement announcement) {
        em.persist(announcement);
    }


    public Announcement find(Long id) {
        return em.find(Announcement.class, id);
    }

    public List<Announcement> findAll() {
        return em.createQuery("SELECT a FROM Announcement a", Announcement.class).getResultList();
    }
    
    public Announcement findLatest() {
        try {
            return em.createQuery("SELECT a FROM Announcement a ORDER BY a.createdAt DESC", Announcement.class)
                     .setMaxResults(1)
                     .getSingleResult();
        } catch (Exception e) {
            // Return null or handle if no announcements are found
            return null;
        }
    }
    
}
