package com.bootsmytool.beststore.services;

import org.springframework.data.jpa.repository.JpaRepository;

import com.bootsmytool.beststore.models.Product;

public interface ProductsRepository extends JpaRepository<Product, Integer>{

}
