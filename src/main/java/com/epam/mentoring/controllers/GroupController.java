package com.epam.mentoring.controllers;

import com.epam.mentoring.models.ProductGroup;
import com.epam.mentoring.services.EcommerceService;
import java.util.List;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/group")
public class GroupController {

  @Autowired EcommerceService ecommerceService;

  @Autowired Validator groupValidator;

  @InitBinder
  protected void initBinder(WebDataBinder binder) {
    binder.addValidators(groupValidator);
  }

  @GetMapping
  public List<ProductGroup> index() {
    return ecommerceService.getGroups();
  }

  @GetMapping("/{id}")
  public ProductGroup view(@PathVariable("id") long id) {
    return ecommerceService.getGroup(id);
  }

  @PostMapping(value = "/{id}")
  public ProductGroup edit(
      @PathVariable(value = "id", required = false) long id,
      @RequestBody @Valid ProductGroup group) {

    ProductGroup updatedGroup = ecommerceService.getGroup(id);

    if (updatedGroup == null) {
      return null;
    }

    updatedGroup.setGroupName(group.getGroupName());
    updatedGroup.setPrice(group.getPrice());
    updatedGroup.setGroupVariants(group.getGroupVariants());

    // We must do this manually b/c of Hibernate.
    if (updatedGroup.getGroupVariants() != null) {
      updatedGroup.getGroupVariants().forEach(gv -> gv.setGroup(updatedGroup));
    }

    return ecommerceService.saveGroup(updatedGroup);
  }

  @PostMapping
  public ProductGroup create(@RequestBody @Valid ProductGroup group) {

    // We must do this manually b/c of Hibernate.
    if (group.getGroupVariants() != null) {
      group.getGroupVariants().forEach(gv -> gv.setGroup(group));
    }

    return ecommerceService.saveGroup(group);
  }

  // Todo: add delete method

}
