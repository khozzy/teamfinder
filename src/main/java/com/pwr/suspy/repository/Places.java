package com.pwr.suspy.repository;

import com.pwr.suspy.domain.Place;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface Places extends JpaRepository<Place, Long> {

}