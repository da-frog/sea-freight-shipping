from dataclasses import dataclass

from .base import BaseModel


@dataclass
class ContainerModel(BaseModel):
    instances = []
    fields = (
        'Container Model Key', 'ISO Size Code', 'ISO Type Code', 'Model Description', 'Owner Code',
        'Serial Number Range Start', 'Serial Number Range End', 'Inside Length (mm)', 'Inside Width (mm)',
        'Inside Height (mm)', 'Inside Middle Height (mm)', 'Inside Side Height (mm)', 'Max stow Height',
        'Roof Opening Length (mm)', 'Roof Opening Width (mm)', 'Door Opening Width (mm)',
        'Door Opening Height (mm)', 'Door Opening Width C (mm)', 'Door Opening Width D (mm)',
        'Door Opening Width B (mm)', 'Door Opening Height E (mm)', 'Door Opening Height F (mm)',
        'Max Gross Weight (kg)', 'Tare Weight (kg)', 'Max Payload Weight (kg)', 'Capacity (cbm)'
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
