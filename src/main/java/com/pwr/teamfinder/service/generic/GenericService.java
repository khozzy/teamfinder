package com.pwr.teamfinder.service.generic;


import com.pwr.teamfinder.domain.BaseEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.io.Serializable;
import java.util.Collection;

public interface GenericService<T extends BaseEntity, PK extends Serializable, R extends JpaRepository<T, PK>> {
    R getRepository();

    T save(T entity);

    void delete(PK id);

    void delete(T entity);

    Collection<T> getAll();

    T findById(PK id);
}
