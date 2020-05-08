from dataclasses import dataclass

from .base import BaseModel


@dataclass
class ContainerModel(BaseModel):
    _instances = []
    fields = (
        ('Container Model Key', None, 'int'),
        ('ISO Size Code', None, 'nvarchar(2)'),
        ('ISO Type Code', None, 'nvarchar(2)'),
        ('Model Description', None, 'nvarchar(255)'),
        ('Owner Code', None, 'nvarchar(4)'),
        ('Serial Number Range Start', None, 'int'),
        ('Serial Number Range End', None, 'int'),
        ('Inside Length (mm)', None, 'int'),
        ('Inside Width (mm)', None, 'int'),
        ('Inside Height (mm)', None, 'int'),
        ('Inside Middle Height (mm)', None, 'int'),
        ('Inside Side Height (mm)', None, 'int'),
        ('Max stow Height', None, 'int'),
        ('Roof Opening Length (mm)', None, 'int'),
        ('Roof Opening Width (mm)', None, 'int'),
        ('Door Opening Width (mm)', None, 'int'),
        ('Door Opening Height (mm)', None, 'int'),
        ('Door Opening Width C (mm)', None, 'int'),
        ('Door Opening Width D (mm)', None, 'int'),
        ('Door Opening Width B (mm)', None, 'int'),
        ('Door Opening Height E (mm)', None, 'int'),
        ('Door Opening Height F (mm)', None, 'int'),
        ('Max Gross Weight (kg)', None, 'int'),
        ('Tare Weight (kg)', None, 'int'),
        ('Max Payload Weight (kg)', None, 'int'),
        ('Capacity (cbm)', None, 'decimal')
    )

    container_model_key: int
    iso_size_code: str
    iso_type_code: str
    owner_code: str
    model_description: str = ''
    serial_number_range_start: int = None
    serial_number_range_end: int = None
    inside_length_mm: float = None
    inside_width_mm: float = None
    inside_height_mm: float = None
    inside_middle_height_mm: float = None
    inside_side_height_mm: float = None
    max_stow_height: float = None
    roof_opening_length_mm: float = None
    roof_opening_width_mm: float = None
    door_opening_width_mm: float = None
    door_opening_height_mm: float = None
    door_opening_width_c_mm: float = None
    door_opening_width_d_mm: float = None
    door_opening_width_b_mm: float = None
    door_opening_height_e_mm: float = None
    door_opening_height_f_mm: float = None
    max_gross_weight_kg: float = None
    tare_weight_kg: float = None
    max_payload_weight_kg: float = None
    capacity_cbm: float = None

    @property
    def container_class_key(self) -> int:
        return self.key
