/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import bean.Store;
import bean.Tag;
import bean.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author poonkaho
 */
@WebServlet(name = "HandleTag", urlPatterns = {"/HandleTag"})
public class HandleTag extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");
        if ("getTags".equalsIgnoreCase(action)) {
            try {
                HttpSession httpSession = request.getSession(false);
                User user = (User) httpSession.getAttribute("user");

                ArrayList<Tag> tags = new ArrayList<Tag>(user.getTagCollection());

                JSONArray array = new JSONArray();

                JSONObject store;
                //declare for each store
                JSONObject jsonObject = new JSONObject();

                for (int x = 0; x < tags.size(); x++) {
                    store = new JSONObject();
                    store.put("storeName", tags.get(x).getStoreID().getStoreName());
                    store.put("storeId", tags.get(x).getStoreID().getStoreID());
                    array.put(store);
                    //stack overflow easily happens
                }

                jsonObject.put("tags", array);
                out.println(jsonObject);


            } catch (JSONException ex) {
                Logger.getLogger(HandleTag.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                out.close();
            }
        } else if ("addTag".equalsIgnoreCase(action)) {
            try {
                HttpSession httpSession = request.getSession(false);
                User user = (User) httpSession.getAttribute("user");

                String storeId = request.getParameter("storeId");

                EntityManagerFactory factory = Persistence.createEntityManagerFactory("ProductSearch_3PU");
                EntityManager em = factory.createEntityManager();
                em.getTransaction().begin();

                Tag tag = new Tag();
                tag.setTagID(1);
                tag.setCreationTime(new Date());
                tag.setUserID(user);
                
                
                tag.setStoreID(em.find(Store.class, Integer.parseInt(storeId)));
                em.persist(tag);

                User newUser = em.find(User.class, user.getUserID());
                httpSession.setAttribute("user", newUser);
                //renew the bean.user in user

                //User user = em.find(User.class, userId);
                em.getTransaction().commit();
                em.close();
                factory.close();

                out.println("true");
            } catch (Exception ex) {
                Logger.getLogger(HandleTag.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                out.close();
            }
        } else if ("cancelTag".equalsIgnoreCase(action)) {
            try {
                HttpSession httpSession = request.getSession(false);
                User user = (User) httpSession.getAttribute("user");

                String storeId = request.getParameter("storeId");
                
                EntityManagerFactory factory = Persistence.createEntityManagerFactory("ProductSearch_3PU");
                EntityManager em = factory.createEntityManager();
                em.getTransaction().begin();


                
                ArrayList<Tag> tags = new ArrayList<Tag>(user.getTagCollection());
                for (int x = 0; x < tags.size() ; x++) {
                    if (storeId.equalsIgnoreCase("" + tags.get(x).getStoreID().getStoreID())) {
                        Tag tag = em.merge(tags.get(x));
                        em.remove(tag);
                    }
                }
                
                User newUser = em.find(User.class, user.getUserID());
                httpSession.setAttribute("user", newUser);
                //renew the bean.user in user

                //User user = em.find(User.class, userId);
                em.getTransaction().commit();
                em.close();
                factory.close();

                out.println("true");
            } catch (Exception ex) {
                Logger.getLogger(HandleTag.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                out.close();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
