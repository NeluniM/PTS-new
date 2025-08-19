package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.Sauserm;

public interface SecurityDao {
    Boolean validateLogin(String userName, String password) throws Exception;
    Sauserm getSauserm(String userName);
}