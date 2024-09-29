using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace OnbhoardingTask.Models;

public partial class Customer
{
    public int Id { get; set; }
    [Required]
    public string? Name { get; set; }

    public string? Address { get; set; }

    public virtual ICollection<Sale> Sales { get; set; } = new List<Sale>();
}
