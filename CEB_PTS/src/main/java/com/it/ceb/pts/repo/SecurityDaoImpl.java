package com.it.ceb.pts.repo;

import jakarta.persistence.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.it.ceb.pts.domain.Sauserm;
import java.util.List;

@Repository
@Transactional
public class SecurityDaoImpl implements SecurityDao {

    @Autowired
    private EntityManager em;

    @Override
    public Boolean validateLogin(String userName, String password) throws Exception {
        Sauserm user = getSauserm(userName);
        if (user == null) {
            return false;
        }

        // ACCESS PASSWORD WITHOUT SPACES
        String dbHint = user.getPswrdHint() != null ? user.getPswrdHint().trim() : "";
        String inputPwd = password != null ? password.trim() : "";
        return inputPwd.equals(dbHint);
    }

    @Override
    public Sauserm getSauserm(String userName) {
        String qryStr = "SELECT s FROM Sauserm s WHERE TRIM(s.userId)=:userName";
        Query query = em.createQuery(qryStr);
        query.setParameter("userName", userName.trim().toUpperCase());
        List<Sauserm> list = query.getResultList();
        if (list.isEmpty())
            return null;
        else if (list.size() == 1)
            return list.get(0);
        throw new NonUniqueResultException();
    }
}